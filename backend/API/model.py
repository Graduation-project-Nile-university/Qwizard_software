from functions import Functions
from fastapi import APIRouter, Body, status, Response, FastAPI, UploadFile, File
from bs4 import BeautifulSoup
import fitz
#a0g35pBKQUVW

qwizard_model = APIRouter()

@qwizard_model.post("/uploadpdf")
async def preprocess_pdf_file( response: Response, pdf: UploadFile = File()):
    try:
        html_content = ""
        divs_included_images = []
        images_with_description_in_pdf = []

        
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
