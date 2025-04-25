
from flask import Flask, jsonify
import json

app = Flask("my_flask_app")


@app.route('/')
def serve_scraped_data():
    try:
        with open('scraped_data.json', 'r') as f:
            data = json.load(f)
        return jsonify(data)
    except FileNotFoundError:
        return jsonify({'error': 'scraped_data.json not found'}), 404

if __name__ == '__main__':
    print("Flask app Runnning..")
    app.run(host='0.0.0.0', port=5000)

