from flask import Flask, jsonify
from auth.routes import auth_bp
from items.routes import items_bp
from cart.routes import cart_bp
from orders.routes import orders_bp

app = Flask(__name__)

app.register_blueprint(auth_bp, url_prefix='/auth')
app.register_blueprint(items_bp, url_prefix='/items')
app.register_blueprint(cart_bp, url_prefix='/cart')
app.register_blueprint(orders_bp, url_prefix='/orders')

@app.route('/')
def home():
    return jsonify(message="Connected to MongoDB")

if __name__ == '__main__':
    app.run(debug=True)
