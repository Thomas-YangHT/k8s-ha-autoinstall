#!/usr/bin/python
from flask import Flask
app = Flask(__name__)
 
@app.route('/myapp')
def index():
    return '<h1>Hello World</h1>'
if __name__ == '__main__':
    app.run(host="0.0.0.0",port=5000)
