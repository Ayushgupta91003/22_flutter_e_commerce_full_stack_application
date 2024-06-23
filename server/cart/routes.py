from flask import Blueprint, request, jsonify
from extensions import db

cart_bp = Blueprint('cart', __name__)

@cart_bp.route('/add', methods=['POST'])
def add_to_cart():
    data = request.json
    db.cart.insert_one(data)
    return jsonify({"message": "Item added to cart"}), 201

@cart_bp.route('/checkout', methods=['POST'])
def checkout():
    data = request.json
    db.orders.insert_one(data)
    db.cart.delete_many({"user_id": data["user_id"]})
    return jsonify({"message": "Order placed successfully"}), 201
