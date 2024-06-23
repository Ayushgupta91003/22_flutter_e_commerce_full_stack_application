import os
from urllib.parse import quote_plus

password = quote_plus("Aryan@123")
MONGO_URI = f"mongodb+srv://ayush91003:{password}@cluster0.odkaxap.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
