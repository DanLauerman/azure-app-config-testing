from flask import Flask, jsonify, make_response
from flask_restful import Api, Resource
import json

app = Flask(__name__)
api = Api(app)

@app.route("/")
def home():
    return "<h2>Hello!</h2> <p>There is nothing here!</p>"

class ConfigVal(Resource):
    def get(self):
        return jsonify({'message': 'hello world'})

api.add_resource(ConfigVal, "/config_value")



