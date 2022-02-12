import flask
import analytics
from flask_restful import Api
from flask import Flask, render_template, request, jsonify

app = Flask(__name__)
api = Api(app)

@app.route("/")
def index():
    return render_template('index.html')

@app.route("/parseKeystrokes", methods=['POST'])
def parseKeystrokes():
    if request.method == 'POST':
        try:
            data = request.get_json()
            log = data['logs']
            filtered_log = "Filtered log: \n" + analytics.cleanLog(log)
            summary = analytics.evaluateKeywords(filtered_log)
            return flask.jsonify(filteredLogs=filtered_log, summary=summary)

        except Exception as e:
            print(e)
            return flask.jsonify(filteredLogs='', summary='Something went wrong :(')


@app.route("/addKeywords", methods=['POST'])
def addKeywords():
    if request.method == 'POST':
        try:
            data = request.data
            new_categories = analytics.updateCategories(data)
            if new_categories:
                return flask.jsonify(result="Category update successful!")

        except Exception as e:
            print(e)
            return flask.jsonify(result='''Invalid category or keyword format!
            Max 26 characters for each word allowed!''')

if __name__ == "__main__":
    app.run()