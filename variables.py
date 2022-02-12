new_category_validator = r'[^\s][a-zA-Z_0-9\s]{1,26}[^\s]'
new_value_validator = r'[^\s].{1,26}[^\s]'

replacers = [
	['\r', '\n'],
	[r'<Window[^>]*>', '\n'],
	['«Enter»', '\n'],
	['«Tab»','	'],
	[r'«[^»]*»', '']
]

categories = [
	{"name": "email", "keyword_regex": r"gmail|wp|onet|interia|o2|outlook|protonmail|icloud|thunderbird|@"},
	{"name": "social media", "keyword_regex": r"facebook|instagram|twitter|linkedin|reddit|snapchat|pinterest|tiktok|wykop|twitch"},
	{"name": "search engines", "keyword_regex": r"google|bing|yandex|yahoo|duckduckgo"},
	{"name": "programming", "keyword_regex": r"github|git|aws|azure|gcp"},
	{"name": "news/entertainment portals", "keyword_regex": r"youtube|dailymotion|vimeo|onet|twitch|netflix|hulu"},
	{"name": "banks", "keyword_regex": r"mbank|bankmillenium|pkobp|ipko|pekao|santander|ing|ingbank|aliorbank|alior|bnp|bnpparibas|bos|bosbank|getin|getinbank"},
	{"name": "online shopping", "keyword_regex": r"allegro|ebay|amazon|olx|ceneo|aliexpress|mediaexpert|zalando|zara|zooplus|oponeo|x-kom|ikea|empik|reserved|nike|bonprix|eobuwie|morele|mediamarkt|tesco|leroymerlin|sephora|smyk|obi|castorama|aboutyou|apart|sinsay|orsay|hebe|neonet|answear|komputronik|sfd|decathlon|notino|renee|tchibo|bershka|allegro|4f|zalando-lounge|oleole|apteka-melissa|mohito|amazon|sizeer|adidas|51015kids|limango"},
	{"name": "domains", "keyword_regex": r"\.(pl|com|net|org|co|edu|gov|tk|uk|de)"}
]