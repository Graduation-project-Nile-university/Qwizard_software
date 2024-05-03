import re
import jwt
from passlib.context import CryptContext
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import random
import smtplib

context = CryptContext(schemes=["bcrypt"], deprecated="auto")

class Functions:
    def isPasswordStrong(password:str)->bool:
        if password.__len__() > 8 and re.fullmatch(r".*[0-9a-zA-Z]", password):
            return True
        return False
    def verifyPassword(password: str, hashedPassword: str) -> bool:
        return context.verify(password, hashedPassword)

    def hashPassword(password):
        return context.hash(password)
    
    def getToken(payloads:dict):
        token = jwt.encode(payloads, key="Quizard2024", algorithm="HS256")
        return token
    
    def decodeToken(token:str):
        return jwt.decode(token, key="Quizard2024",algorithms=["HS256"])
    
    def forgotPasswordEmail(sendTo: str):
        otp = random.randrange(1000, 9999)

        message = MIMEMultipart()

        message.add_header("From", "Quizard")
        message.add_header("To", "you")
        message.add_header("Subject", "Reset your Quizard password" )
        message.attach(MIMEText(
        f"""
        <br/>
        <h2>Change your Quizard password</h2>
        your OTP is:
        <h3>{otp}</h3>
        </body>
        """, "html"))

        server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
        server.ehlo()
        server.login("quizard2024@gmail.com", "cbqljpkciohdbzne")
        server.sendmail("Quizard", sendTo, message.as_string())
        return str(otp)