import enum
from datetime import datetime

from flask import Flask
from flask_admin import Admin
from flask_sqlalchemy import SQLAlchemy
from flask_admin.model import InlineFormAdmin
from flask_admin.contrib.sqla import ModelView
from flask_login import LoginManager, current_user,UserMixin,login_user
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your_secret_key'
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///database.db"
db= SQLAlchemy(app)
login_manager = LoginManager(app)
login_manager.login_view = 'login'

#Enum
class StatusEnum(enum.Enum):
    present = "Present"
    absent = "Absent"
    on_duty = "On Duty"
#Models
class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(1000),nullable = False)
    nfc_serial = db.Column(db.String(100),unique = True, nullable = False)
    roll_no = db.Column(db.String(1000),nullable = False)
    faculty_registered = db.Column(db.String(1000),nullable = False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    admin = db.Column(db.Boolean, default=False)
    def is_admin(self):
        return self.admin
    def get_id(self):
        return str(self.id)
    def __repr__(self):
        return self.username
class Meeting(db.Model):
    id = db.Column(db.Integer, primary_key = True)
    name = db.Column(db.String(1000),nullable = False)
    created_at = db.Column(db.DateTime)
    
    def __repr__(self):
        return self.name

class Attendance(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    meeting_id = db.Column(db.Integer, db.ForeignKey('meeting.id'), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    status = db.Column(db.Enum(StatusEnum), default=StatusEnum.absent, nullable=False)
    date = db.Column(db.DateTime)
    meeting = db.relationship('Meeting', backref=db.backref('attendances', lazy='dynamic'))
    user = db.relationship('User', backref=db.backref('attendances', lazy='dynamic'))
# Customized model view for admin
class MyModelView(ModelView):
    column_hide_backrefs = False
    column_display_pk = True
    def is_accessible(self):
        return current_user.is_authenticated and current_user.is_admin
class MyAttendanceModelView(ModelView):
    column_list = ['meeting', 'user', 'status', 'date']

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))
@app.route('/login')
def login():
    # Implement your login logic here
    user = User.query.filter_by(username='Shyam').first()
    login_user(user)
    return 'Logged in successfully!'
@app.route('/create/db')
def create_db():    
    db.create_all()
    return "",200
if __name__ == "__main__":
    admin = Admin(app, name='Admin')
    admin.add_view(MyModelView(User, db.session))
    admin.add_view(MyModelView(Meeting, db.session))
    admin.add_view(MyAttendanceModelView(Attendance, db.session))
    app.run(debug = True)