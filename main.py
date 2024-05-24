from fastapi import APIRouter, Body, status, Response, FastAPI
from schemas import *
from database import Database
from authentication import authentication
from model import qwizard_model
import uvicorn

app = FastAPI()

@app.get("/")
def welcome():
    return "Hello this is Quizard"

app.include_router(authentication)
app.include_router(qwizard_model)

if __name__ == "__main__":
    uvicorn.run("main:app", reload=True)
