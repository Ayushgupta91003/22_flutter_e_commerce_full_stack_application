from flask import Blueprint, request, jsonify
from extensions import db
from bson.objectid import ObjectId

cart_bp = Blueprint('cart', __name__)

@cart_bp.route('/add', methods=['POST'])
def add_to_cart():
    data = request.json
    db.cart.insert_one(data)
    return jsonify({"message": "Item added to cart"}), 201

@cart_bp.route('/<user_id>', methods=['GET'])
def get_cart_items(user_id):
    cart_items = list(db.cart.find({"user_id": user_id}))
    for item in cart_items:
        item["_id"] = str(item["_id"])
    return jsonify(cart_items), 200

@cart_bp.route('/remove/<item_id>', methods=['DELETE'])
def remove_from_cart(item_id):
    db.cart.delete_one({"_id": ObjectId(item_id)})
    return jsonify({"message": "Item removed from cart"}), 200
