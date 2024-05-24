import re
import jwt
from passlib.context import CryptContext
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import random
import smtplib
from base64 import b64decode
import PIL.Image, io
import re
import google.generativeai as genai

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
        otp = random.randrange(100000, 999999)

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
    
    def convert_image_to_text(image_data:str):
        processed_image_data = re.sub("(data:image/png;base64,\n)|(data:image/jpeg;base64,\n)|(data:image/jpg;base64,\n)","", image_data)
        image_bytes = b64decode(processed_image_data)
        image = PIL.Image.open(io.BytesIO(image_bytes))
        genai.configure(api_key="AIzaSyC0X-qg7ln_KHwEI8nvKlm9mjNchQIDS6k")
        model = genai.GenerativeModel("gemini-pro-vision")
        description = model.generate_content(image).text
        return description