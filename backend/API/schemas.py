from pydantic import BaseModel
from enum import Enum

class Membership(Enum):
    Basic = 1
    Premium = 2
    Gold = 3

class User(BaseModel):
    email: str
    password: str
    phoneNumber: str = ""
    membershipPlan: Membership = Membership.Basic.name

class UserSignup(User):
    username: str
