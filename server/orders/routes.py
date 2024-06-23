from flask import Blueprint, request, jsonify
from extensions import db
from bson.objectid import ObjectId

orders_bp = Blueprint('orders', __name__)

@orders_bp.route('/place', methods=['POST'])
def place_order():
    data = request.json
    user_id = data["user_id"]
    
    # Fetch all cart items for the user
    cart_items = list(db.cart.find({"user_id": user_id}))
    
    if not cart_items:
        return jsonify({"message": "No items in cart"}), 400
    
    # Create an order with cart items
    order_data = {
        "user_id": user_id,
        "items": cart_items,
        "total_amount": data["total_amount"]
    }
    db.orders.insert_one(order_data)
    
    # Clear the cart for the user
    db.cart.delete_many({"user_id": user_id})
    
    return jsonify({"message": "Order placed successfully"}), 201

@orders_bp.route('/<user_id>', methods=['GET'])
def get_user_orders(user_id):
    orders = list(db.orders.find({"user_id": user_id}))
    for order in orders:
        order["_id"] = str(order["_id"])
        for item in order["items"]:
            item["_id"] = str(item["_id"])
            item["item_id"] = str(item["item_id"])
    return jsonify(orders), 200
