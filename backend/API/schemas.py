from pydantic import BaseModel
from enum import Enum

class User(BaseModel):
    email: str
    password: str
    phoneNumber: str = ""
    membershipPlan: str = "FREE"
    numOfGens: int = 5


class UserSignup(User):
    username: str

class History(BaseModel):
    exam: str
    title: str
    generatedScore: int
    humanScore: int