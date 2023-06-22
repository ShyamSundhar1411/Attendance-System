from datetime import datetime
from backend import db
from backend.choices import *
from sqlalchemy_utils import ChoiceType
from flask_login import UserMixin

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
    status = db.Column(ChoiceType(STATUS_CHOICES),nullable=False,info = {"label":"Unit"})
    date = db.Column(db.DateTime)
    meeting = db.relationship('Meeting', backref=db.backref('attendances', lazy='dynamic'))
    user = db.relationship('User', backref=db.backref('attendances', lazy='dynamic'))