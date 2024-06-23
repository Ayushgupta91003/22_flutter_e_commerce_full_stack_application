from flask import Blueprint, request, jsonify
from extensions import db

auth_bp = Blueprint('auth', __name__)

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
        return jsonify({"message": "Login successful"}), 200
    else:
        return jsonify({"message": "Invalid credentials"}), 401
