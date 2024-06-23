from flask import Blueprint, jsonify
from extensions import db

items_bp = Blueprint('items', __name__)

@items_bp.route('/items', methods=['GET'])
def get_items():
    items = list(db.items.find())
    for item in items:
        item["_id"] = str(item["_id"])
    return jsonify(items), 200
