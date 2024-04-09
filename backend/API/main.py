from fastapi import APIRouter, Body, status, Response, FastAPI
from backend.API.uploading_docs import qwizard_models
from backend.API.schemas import *
from backend.API.database import Database
from backend.API.authentication import authentication

app = FastAPI()
app.include_router(authentication)
app.include_router(qwizard_models)
