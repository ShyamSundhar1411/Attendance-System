from backend import app,db
from backend.models import *
from backend.schemas import *
from flask import jsonify
from flask_login import LoginManager, current_user,UserMixin,login_user,logout_user,login_required



login_manager = LoginManager(app)
login_manager.login_view = 'login'

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))
@app.route('/login')
def login():
    # Implement your login logic here
    user = User.query.filter_by(username='Shyam').first()
    login_user(user)
    return 'Logged in successfully!'
@app.route('/',methods = ['GET'])
def home():
    users = User.query.all()
    data = user_schema.dump(users)
    return jsonify(data)
@app.route('/create/db')
def create_db():    
    db.create_all()
    return "",200
