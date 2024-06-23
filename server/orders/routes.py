from flask import Blueprint, jsonify
from extensions import db

orders_bp = Blueprint('orders', __name__)

@orders_bp.route('/all', methods=['GET'])
def get_orders():
    orders = list(db.orders.find())
    for order in orders:
        order["_id"] = str(order["_id"])
    return jsonify(orders), 200
