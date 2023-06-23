from backend import my_schema_builder,app,db
from backend.models import *

class UserSchema(my_schema_builder.SQLAlchemyAutoSchema):
    class Meta:
        model = User
        
class MeetingSchema(my_schema_builder.SQLAlchemyAutoSchema):
    class Meta:
        model = Meeting
        include_fk = True
class AttendanceSchema(my_schema_builder.SQLAlchemyAutoSchema):
    class Meta:
        model = Attendance
        include_fk = True
user_schema = UserSchema(many = True)
meeting_schema = MeetingSchema(many = True)
attendance_schema = AttendanceSchema(many = True)