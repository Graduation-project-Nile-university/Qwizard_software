from fastapi import APIRouter, Body, status, Response, FastAPI
from api import qwizard_models

app = FastAPI()

app.include_router(qwizard_models)
