from datetime import time
from schemas import History
from functions import Functions
from fastapi import APIRouter, Body, status, Response, FastAPI, UploadFile, File, Request
from bs4 import BeautifulSoup
import fitz
from database import database


qwizard_model = APIRouter()


@qwizard_model.post("/download_exam")
def downloadExam(response:Response, data: dict=Body(...)):
    try:
        exam = data["exam"]
        email = data["email"]
        current_time_millis = int(time.time() * 1000)
        pdf_file_name = f"{email}_{current_time_millis}.pdf"
        Functions.createPDF(pdf_file_name, "Generated Exam", exam)
        Functions.sendExam(email, pdf_file_name)
        
    except Exception as e:
        response.status_code = status.HTTP_403_FORBIDDEN
        return {"failure": "failed"}

@qwizard_model.post("/updateNumOfGens")
async def update_num_of_gens(response: Response,token:Request, data:History):
    try:
        email = token.headers["email"]
        await database.update_num_of_gens(email)
        database.add_to_history(data, email)
        return {"success":"Updated successfully"}
    except Exception as e:
        print(e.args)
        response.status_code = status.HTTP_403_FORBIDDEN
        return {"failure":e.args} 

@qwizard_model.get("/{email}/getUserHistory")
def getUserHistory(response: Response, email:str):
    try:
        history = []
        for i in database.get_history(email).find():
            i["_id"] = str(i["_id"])
            history.append(i)
        return history
    except Exception as e:
        response.status_code = status.HTTP_403_FORBIDDEN
        return e
        

@qwizard_model.post("/generateExam")
async def preprocess_pdf_and_generate(response: Response, pdf: UploadFile = File()): 
    try:
        html_content = ""
        divs_included_images = []
        images_with_description_in_pdf = []

        
        doc = fitz.open(stream = pdf.file.read(), filetype="pdf")
        for page_num in range(doc.page_count):
            page = doc[page_num]
            html_content += page.get_text("html")

        file = BeautifulSoup(html_content, "html.parser")
        print(file)
        divs = file.findAll("div")
        for div in divs:
            if div.findAll("img").__len__() > 0:
                divs_included_images.append(div)

        for div in divs_included_images:
            now = "p"
            for i in div:
                if i.name == "img":
                    images_with_description_in_pdf.append(Functions.convert_image_to_text(i.attrs["src"]))
                    now = "img"
                elif i.name == "p" and now=="img":
                    images_with_description_in_pdf.append(i.text)
                    now="p"

        textInFile = file.text
        for i in range(1, len(images_with_description_in_pdf), 2):
            textInFile = textInFile.replace(images_with_description_in_pdf[i], " image: "+images_with_description_in_pdf[i-1])
        return textInFile
    except Exception as e:
        return e.args



@qwizard_model.post("/generateExam2")
async def preprocess_pdf_and_generate2(response: Response, pdf: UploadFile = File()): 
    try:
        html_content = ""
        divs_included_images = []
        images_in_pdf = []

        
        doc = fitz.open(stream = pdf.file.read(), filetype="pdf")
        for page_num in range(doc.page_count):
            page = doc[page_num]
            html_content += page.get_text("html")

        file = BeautifulSoup(html_content, "html.parser")

        divs = file.findAll("div")
        for div in divs:
            if div.findAll("img").__len__() > 0:
                divs_included_images.append(div)

        for div in divs_included_images:
            for i in div:
                if i.name == "img":
                    images_in_pdf.append(i.attrs["src"])

        if images_in_pdf.__len__() > 0:
            images_descriptions = Functions.convert_image_to_text(images_in_pdf)
            textInFile = file.text
            textInFile += images_descriptions
        else:
            textInFile = file.text
        return textInFile
    except Exception as e:
        response.status_code = status.HTTP_403_FORBIDDEN
        return e.args
    
