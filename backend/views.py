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
@app.route('/get/users/all/',methods = ['GET'])
def get_users():
    users = User.query.all()
    return user_schema.jsonify(users)
@app.route('/get/meetings/all/',methods = ['GET'])
def get_meetings():
    meetings = Meeting.query.all()
    return meeting_schema.jsonify(meetings)
@app.route('/get/attendances/all/',methods = ['GET'])
def get_attendances():
    attendances = Attendance.query.all()
    return attendance_schema.jsonify(attendances)
@app.route('/create/db')
def create_db():    
    db.create_all()
    return "",200
