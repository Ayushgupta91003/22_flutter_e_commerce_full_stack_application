import jwt
import datetime
from flask import Blueprint, request, jsonify
from extensions import db
from bson.objectid import ObjectId

auth_bp = Blueprint('auth', __name__)
SECRET_KEY = "your_secret_key"

@auth_bp.route('/register', methods=['POST'])
def register():
    data = request.json
    if db.users.find_one({"email": data["email"]}):
        return jsonify({"message": "User already exists"}), 400
    db.users.insert_one(data)
    return jsonify({"message": "User registered successfully"}), 201

@auth_bp.route('/login', methods=['POST'])
def login():
    data = request.json
    user = db.users.find_one({"email": data["email"], "password": data["password"]})
    if user:
        token = jwt.encode({
            'user_id': str(user['_id']),
            'exp': datetime.datetime.utcnow() + datetime.timedelta(hours=1)
        }, SECRET_KEY, algorithm='HS256')
        return jsonify({"token": token}), 200
    else:
        return jsonify({"message": "Invalid credentials"}), 401

@auth_bp.route('/update_profile', methods=['PUT'])
def update_profile():
    data = request.json
    email = data.get("email")
    if not email:
        return jsonify({"message": "Email is required"}), 400
    update_fields = {k: v for k, v in data.items() if k != "email"}
    db.users.update_one({"email": email}, {"$set": update_fields})
    return jsonify({"message": "Profile updated successfully"}), 200
