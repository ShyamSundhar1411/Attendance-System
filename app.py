import enum
from datetime import datetime


from flask_admin import Admin

from flask_admin.model import InlineFormAdmin
from flask_admin.contrib.sqla import ModelView
from flask_login import LoginManager, current_user,UserMixin,login_user
from werkzeug.security import generate_password_hash, check_password_hash


login_manager = LoginManager(app)
login_manager.login_view = 'login'

#Enum
class StatusEnum(enum.Enum):
    present = "Present"
    absent = "Absent"
    on_duty = "On Duty"

# Customized model view for admin


