from functools import wraps
from flask import request, jsonify
from extensions import db

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = request.headers.get('x-access-token')
        if not token:
            return jsonify({"message": "Token is missing!"}), 403
        try:
            user = db.users.find_one({"token": token})
            if not user:
                return jsonify({"message": "Invalid token!"}), 403
        except:
            return jsonify({"message": "Token is invalid!"}), 403
        return f(*args, **kwargs)
    return decorated
