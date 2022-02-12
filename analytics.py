from variables import *
import json
import collections, re

def cleanLog(data):
	print('[+] Parsing keystroke log...')
	try:
		print(data)
		parsed_log = data
		for r in replacers:
			to_replace = r[0]
			replaced_by = r[1]
			parsed_log = re.sub(to_replace, replaced_by, parsed_log)
		print('[+] Done!')
		print(parsed_log)
		return parsed_log

	except Exception as e:
		print(e)


def evaluateKeywords(data):
	print('[+] Searching for keywords...')
	summary, found_categories = "", []
	try:
		for c in categories:
			cat_keywords = re.findall(c.get("keyword_regex"), data.lower())
			if cat_keywords:
				found_categories.append({'name': c.get('name'), 'keywords': cat_keywords})

		if found_categories:
			summary += "Found keywords that may be related to:\n"
			for fc in found_categories:
				summary += f" - {fc['name']}: {', '.join(fc['keywords'])}\n"

	except Exception as e:
		print(e)

	print('[+] Done!')
	return summary

def updateCategories(data):
	print('[+] Decoding category data...')
	try:
		#Decode and parse data
		arr_string = '{"newCategories":' + data.decode('UTF-8') + '}'
		received_categories = json.loads(arr_string)
		print(received_categories)
		print('[+] Received new categories. Updating...')
		cat_arr = received_categories['newCategories']

		#Add or update categories
		for c in cat_arr:
			if not validCategory(c):
				raise Exception('Invalid category or keyword length!')

			regex = r'|'.join(c['Value']).strip()
			if not categoryExists(c):
				variables.categories.append({'name': c['Key'], 'keyword_regex': regex})
			else:
				updated_keyword_regex = '|' + regex
				cat_to_update = next(cat for cat in variables.categories if cat['name'] == c['Key'])
				cat_to_update['keyword_regex'] += updated_keyword_regex

	except Exception as e:
		print(e)
		return False

	print('[+] Category update successful!')
	print(variables.categories)
	return True

def validCategory(category):
	is_category_valid = re.match(variables.new_category_validator, category['Key'])
	print(is_category_valid.group())
	if len(is_category_valid.group()) != len(category['Key']):
		return False
	for v in category['Value']:
		is_value_valid = re.match(variables.new_value_validator, v)
		if not is_value_valid:
			return False
	return True

def categoryExists(new_cats):
	existing_cats = [c.get('name') for c in variables.categories]
	for cat in new_cats:
		cat_name = cat.get('Key')
		if cat_name in existing_cats:
			print(f'[!] Category {cat_name} found! Appending keywords {cat.get("Value")}...')
			return True
	return False
