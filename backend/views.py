from backend import app,db
from backend.models import *
from backend.schemas import *
from flask import request,jsonify
from flask_migrate import upgrade
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from flask_login import LoginManager, current_user,UserMixin,login_user,logout_user,login_required
from werkzeug.security import check_password_hash
from datetime import timedelta



login_manager = LoginManager(app)
login_manager.login_view = 'login'


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))
@app.route('/',methods = ['GET'])
def home():
    routes = [
        '/get/users/all/',
        '/get/user/<string:serial>/',
        '/get/message/all/',
        '/get/attendances/all/',
        'mark/attendance/',
        '/login/'
    ]
    return jsonify(routes)
@app.route('/get/users/all/',methods = ['GET'])
def get_users():
    users = NFCUser.query.all()
    return nfc_user_schema.jsonify(users)
@app.route('/get/user/<string:serial>/',methods = ['GET'])
def get_user_with_nfc(serial):
    user = NFCUser.query.filter_by(nfc_serial = serial).first()
    return nfc_user_schema.jsonify(user,many=False)
@app.route('/get/meetings/all/',methods = ['GET'])
def get_meetings():
    meetings = Meeting.query.all()
    return meeting_schema.jsonify(meetings)
@app.route('/get/attendances/all/', methods=['GET'])
def get_attendances():
    attendances = Attendance.query.all()
    return attendance_schema.jsonify(attendances, many=True)
@app.route('/get/attendance/<string:serial>/',methods = ['GET'])
def get_attendance_with_nfc(serial):
    user = NFCUser.query.filter_by(nfc_serial=serial).first()
    attendances = Attendance.query.filter_by(user=user).all()
    return attendance_schema.jsonify(attendances)
@app.route('/mark/attendance/', methods=['POST'])
def create_attendance():
    data = request.get_json()
    try:
        attendance = Attendance.query.filter_by(meeting_id = data['meeting_id'],user_id = data['user_id']).first()
        attendance.status = data['status']
        attendance.date = datetime.strptime(data['date'], '%Y-%m-%d %H:%M:%S')
        db.session.commit()
    except:
        attendance = Attendance(meeting_id = data['meeting_id'],user_id = data['user_id'],status = data['status'],date=datetime.strptime(data['date'], '%Y-%m-%d %H:%M:%S'))
        db.session.add(attendance)
        db.session.commit()
    return jsonify({'message': 'Attendance created successfully'})
    # except:
    #     return "Error Processing Request",400
@app.route('/migrate')
def migrate_database():
    with app.app_context():
        upgrade()
    return 'Database migration complete'
@app.route("/api/login", methods=['POST'])
def login():
    data = request.json
    email = data.get('email')
    password = data.get('password')

    if not all([email, password]):
        return jsonify({"message": "Incomplete data"}), 400

    user = User.query.filter_by(email=email).first()
    if not user or not check_password_hash(user.password_hash, password):
        return jsonify({"message": "Invalid email or password"}), 401
    access_token = create_access_token(identity=user.email,expires_delta=timedelta(hours=1))
    email = user.email
    id = user.id
    username = user.username
    user_data = {
            "message": "Account Logged successfully",
            "accessq": access_token,
            "email": email,
            "username": username,
            "id":id,
    }
    return jsonify(user_data), 200
@app.route('/create/db')
def create_db():    
    db.create_all()
    return "",200
@app.route("/api/register", methods=['POST'])
def register():
    data = request.json
    username = data.get('username')
    email = data.get('email')
    password = data.get('password')
    if not all([username, email, password]):
        return jsonify({"message": "Incomplete data"}), 400

    if User.query.filter_by(email=email).first():
        return jsonify({"message": "User already registered"}), 409

    # Hash the password before storing it in the database
    new_user = User(username=username, email=email, password=password)

    try:
        db.session.add(new_user)
        db.session.commit()
        id = new_user.id
        access_token = create_access_token(identity=new_user.email,expires_delta=timedelta(hours=1))
        email = new_user.email
        username = new_user.username
        user_data = {
                "message": "Account created successfully",
                "access_token": access_token,
                "email": email,
                "username": username,
                "id":id
        }
        return jsonify(user_data), 201
    except:
        db.session.rollback()
        return jsonify({"message": "Database error"}), 500
