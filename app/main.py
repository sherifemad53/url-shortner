from flask import Flask, request, jsonify, redirect
import hashlib

app = Flask(__name__)
short_to_url = {}

def generate_short_code(url):
    return hashlib.md5(url.encode()).hexdigest()[:6]

@app.route('/shorten', methods=['POST'])
def shorten():
    data = request.get_json()
    original_url = data.get('url')

    if not original_url:
        return jsonify({"error": "Missing URL"}), 400

    short_code = generate_short_code(original_url)
    short_to_url[short_code] = original_url

    return jsonify({
        "original_url": original_url,
        "short_url": f"http://localhost:5000/{short_code}"
    })

@app.route('/<short_code>')
def redirect_short_url(short_code):
    original_url = short_to_url.get(short_code)
    if original_url:
        return redirect(original_url)
    else:
        return jsonify({"error": "URL not found"}), 404

@app.route('/')
def index():
    return "Simple URL Shortener is running!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
