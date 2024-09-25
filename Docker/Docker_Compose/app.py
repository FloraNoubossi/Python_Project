from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(host='redis-container', port=6379)

@app.route('/')
def hello():
    redis.incr('hits')
    # Décoder la valeur renvoyée par Redis
    hits = redis.get('hits').decode('utf-8')
    return f'This page has been viewed {hits} time(s).'

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)

