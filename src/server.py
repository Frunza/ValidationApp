from flask import Flask, request
from utils import *

app = Flask(__name__)


@app.route('/')
def hello():
    return 'Validation app. Use the validate-yaml endpont to validate that the request body is a valid yaml file'

@app.route('/validate-yaml', methods=["POST"])
def validate_yaml_endpoint():
    data = request.data
    validation_result = validate_yaml(data)
    if validation_result == True:
        return "valid" , 200
    else:
        return "invalid", 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5555)