import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_marshmallow import Marshmallow
from flask_jwt_extended import JWTManager
from flask_cors import CORS

SECRET_KEY = os.urandom(32)
JWT_SECRET_KEY = os.urandom(32)
app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})
app.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///database.db"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = SECRET_KEY
app.config['JWT_SECRET_KEY'] = JWT_SECRET_KEY

db = SQLAlchemy()
db.init_app(app)
migrate = Migrate(app,db)
my_schema_builder = Marshmallow(app)
jwt_manager = JWTManager(app)
from backend import models,views
