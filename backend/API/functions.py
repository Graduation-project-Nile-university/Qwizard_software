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
    def create_pdf(file_name, title, content):
        pdf = FPDF()
        pdf.add_page()

        pdf.set_font("Arial", size=12)
        pdf.cell(200, 10, txt=title, ln=True, align='C')

        pdf.set_font("Arial", size=10)
        pdf.multi_cell(0, 10, txt=content)
        
        pdf.output(file_name)

    def send_email_with_pdf(sendTo, pdf_file_name):
        message = MIMEMultipart()
        message.add_header("From", "Quizard <quizard2024@gmail.com>")
        message.add_header("To", sendTo)
        message.add_header("Subject", "Your Generated Exam")

        body = "Hello,\n\nPlease find attached your generated exam.\n\nBest regards,\nQuizard Team"
        message.attach(MIMEText(body, 'plain'))

        # Attach PDF
        with open(pdf_file_name, "rb") as attachment:
            part = MIMEBase("application", "octet-stream")
            part.set_payload(attachment.read())
            encoders.encode_base64(part)
            part.add_header(
                "Content-Disposition",
                f"attachment; filename= {pdf_file_name}",
            )
            message.attach(part)

        server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
        server.ehlo()
        server.login("quizard2024@gmail.com", "cbqljpkciohdbzne")
        server.sendmail("quizard2024@gmail.com", sendTo, message.as_string())
        server.quit()




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
    
    def convert_image_to_text(images:list[str]):
        try:
            listOfimg = ["generate a description of all the following images please to make them an input to LLM models:"]
            for i in images:
                processed_image_data = re.sub("(data:image/png;base64,\n)|(data:image/jpeg;base64,\n)|(data:image/jpg;base64,\n)","", i)
                image_bytes = b64decode(processed_image_data)
                image = PIL.Image.open(io.BytesIO(image_bytes))
                listOfimg.append(image)
            print(listOfimg)
            genai.configure(api_key="AIzaSyC0X-qg7ln_KHwEI8nvKlm9mjNchQIDS6k")
            model = genai.GenerativeModel("gemini-1.5-flash")
            description = model.generate_content(listOfimg,request_options={"timeout": 5000}).text
            return description
        except Exception as e:
            return e
    
    def getNumOfGensOfPlan(plan:str):
        if plan == "BASIC":
            return 20
        elif plan == "PRO" or plan == "Q-PRO":
            return 1000
        elif plan == "Q-BASIC":
            return 100
