from functions import Functions
from fastapi import APIRouter, Body, status, Response, FastAPI, UploadFile, File

qwizard_model = APIRouter()

@qwizard_model.post("/uploadpdf")
async def preprocess_pdf_file( response: Response, pdf: UploadFile = File()):
    print(pdf.filename)
    return response.body
