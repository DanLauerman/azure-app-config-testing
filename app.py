from flask import Flask, jsonify, make_response
from flask_restful import Api, Resource
import json
import os

app = Flask(__name__)
api = Api(app)

@app.route("/")
def home():
    return "<h2>Hello!</h2> <p>There is nothing here!</p>"

class ConfigVal(Resource):
    def get(self):
        return jsonify({'message': os.getenv('CONFIG_VALUE_SAMPLE')})

api.add_resource(ConfigVal, "/config_value")



