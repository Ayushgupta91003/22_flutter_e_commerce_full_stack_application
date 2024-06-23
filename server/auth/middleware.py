from functools import wraps
from flask import request, jsonify
from extensions import db
from bson.objectid import ObjectId
import jwt

SECRET_KEY = "your_secret_key"

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None
        if 'Authorization' in request.headers:
            token = request.headers['Authorization'].split()[1]  # Bearer token

        if not token:
            return jsonify({'message': 'Token is missing!'}), 403

        try:
            data = jwt.decode(token, SECRET_KEY, algorithms=['HS256'])
            current_user = db.users.find_one({"_id": ObjectId(data['user_id'])})
            if not current_user:
                return jsonify({'message': 'Token is invalid!'}), 403
        except jwt.ExpiredSignatureError:
            return jsonify({'message': 'Token has expired!'}), 403
        except jwt.InvalidTokenError:
            return jsonify({'message': 'Invalid token!'}), 403

        return f(*args, **kwargs)
    return decorated
