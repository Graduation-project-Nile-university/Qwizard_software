from pydantic import BaseModel

class User(BaseModel):
    email: str = "ss"
    password: str

class UserSignup(User):
    username: str