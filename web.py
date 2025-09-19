from flask import Flask
import os

web_app = Flask(__name__)

@web_app.route('/')
def home():
    return "Bot is running by Sam"

if __name__ == "__main__":
    # Correct variable name
    web_app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
