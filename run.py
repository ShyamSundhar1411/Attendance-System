from backend import app,db
from backend.models import *
from flask_login import LoginManager, current_user,UserMixin,login_user,logout_user,login_required
from flask_admin.contrib.sqla import ModelView
from flask_admin import Admin
class MyModelView(ModelView):
    column_hide_backrefs = False
    column_display_pk = True

class MyModelView(ModelView):
    column_hide_backrefs = False
    column_display_pk = True
    
class MyAttendanceModelView(ModelView):
    column_list = ['meeting', 'user', 'status', 'date']

if __name__ == '__main__':
    admin = Admin(app)
    admin._menu = admin._menu[1:]
    admin.add_view(MyModelView(User, db.session))
    admin.add_view(MyModelView(Meeting, db.session))
    admin.add_view(MyAttendanceModelView(Attendance, db.session))
    app.run(debug = True)