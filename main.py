import os
from flask import Flask, request, abort, jsonify

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

if __name__ == '__main__':
    port = os.environ.get('SERVER_PORT')
    if port == None:
        port = 80
    else:
        port = int(port)
    app.run(host='0.0.0.0', port=port)
