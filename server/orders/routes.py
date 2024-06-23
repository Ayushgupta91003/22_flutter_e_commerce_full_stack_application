from flask import Blueprint, request, jsonify
from extensions import db
from bson.objectid import ObjectId

orders_bp = Blueprint('orders', __name__)

@orders_bp.route('/place', methods=['POST'])
def place_order():
    data = request.json
    db.orders.insert_one(data)
    db.cart.delete_many({"user_id": data["user_id"]})
    return jsonify({"message": "Order placed successfully"}), 201

@orders_bp.route('/<user_id>', methods=['GET'])
def get_user_orders(user_id):
    orders = list(db.orders.find({"user_id": user_id}))
    for order in orders:
        order["_id"] = str(order["_id"])
    return jsonify(orders), 200
