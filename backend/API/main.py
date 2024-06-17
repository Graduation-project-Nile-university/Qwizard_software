from fastapi import APIRouter, Body, status, Response, FastAPI
from schemas import *
from database import Database
from authentication import authentication
from model import qwizard_model
from subscription import quizard_subscriptions
import uvicorn

app = FastAPI(namespace="quizard") #a0g35pBKQUVW

@app.get("/")
def welcome():
    return "Hello this is Quizard"

app.include_router(authentication)
app.include_router(qwizard_model)
app.include_router(quizard_subscriptions)

if __name__ == "__main__":
    uvicorn.run("main:app", reload=True)
