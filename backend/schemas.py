from backend import my_schema_builder,app,db
from backend.models import *

class UserSchema(my_schema_builder.SQLAlchemyAutoSchema):
    class Meta:
        model = User
user_schema = UserSchema(many = True)