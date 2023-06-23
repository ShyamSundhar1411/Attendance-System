from backend import app,db
from backend.models import *
from backend.schemas import *
from flask import request,jsonify
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from flask_login import LoginManager, current_user,UserMixin,login_user,logout_user,login_required




login_manager = LoginManager(app)
login_manager.login_view = 'login'


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))
@app.route('/',methods = ['GET'])
def home():
    routes = [
        '/get/users/all/',
        '/get/message/all/',
        '/get/attendances/all/'
        '/login/'
    ]
    return jsonify(routes)
@app.route('/get/users/all/',methods = ['GET'])
def get_users():
    users = NFCUser.query.all()
    return nfc_user_schema.jsonify(users)
@app.route('/get/meetings/all/',methods = ['GET'])
def get_meetings():
    meetings = Meeting.query.all()
    return meeting_schema.jsonify(meetings)
@app.route('/get/attendances/all/',methods = ['GET'])
def get_attendances():
    attendances = Attendance.query.all()
    return attendance_schema.jsonify(attendances)
@app.route('/login/',methods = ['GET','POST'])
def login():
    username = request.json.get('username')
    password = request.json.get('password')
    user = User.query.filter_by(username=username).first()
    user_schema = UserSchema()
    if user and user.check_password(password):
        access_token = create_access_token(identity=user.id)
        return jsonify({'access_token': access_token,"user":user_schema.dump(user)})
    else:
        return jsonify({'message': 'Invalid username or password'}), 401
@app.route('/create/db')
def create_db():    
    db.create_all()
    return "",200
