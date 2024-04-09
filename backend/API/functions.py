import re
import jwt
from passlib.context import CryptContext

class Functions:
    def isPasswordStrong(password:str)->bool:
        if password.__len__() > 8 and re.fullmatch(r".*[0-9a-zA-Z]", password):
            return True
        return False

    def hashPassword(password):
        context = CryptContext(schemes=["bcrypt"], deprecated="auto")
        return context.hash(password)
    
    def getToken(payloads:dict):
        token = jwt.encode(payloads, key="Quizard2024", algorithm="HS256")
        return token
    
    def decodeToken(token:str):
        return jwt.decode(token, key="Quizard2024",algorithms=["HS256"])


