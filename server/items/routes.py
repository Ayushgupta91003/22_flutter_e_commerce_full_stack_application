from flask import Blueprint, request, jsonify
from extensions import db
from bson.objectid import ObjectId

items_bp = Blueprint('items', __name__)

@items_bp.route('/items', methods=['GET'])
def get_items():
    items = list(db.items.find())
    for item in items:
        item["_id"] = str(item["_id"])
    return jsonify(items), 200

@items_bp.route('/items', methods=['POST'])
def add_item():
    data = request.json
    db.items.insert_one(data)
    return jsonify({"message": "Item added successfully"}), 201

@items_bp.route('/items/<item_id>', methods=['PUT'])
def update_item(item_id):
    data = request.json
    db.items.update_one({"_id": ObjectId(item_id)}, {"$set": data})
    return jsonify({"message": "Item updated successfully"}), 200

@items_bp.route('/items/<item_id>', methods=['DELETE'])
def delete_item(item_id):
    db.items.delete_one({"_id": ObjectId(item_id)})
    return jsonify({"message": "Item deleted successfully"}), 200
