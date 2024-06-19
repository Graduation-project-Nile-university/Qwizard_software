from fastapi import Body, APIRouter, Response, status
from functions import Functions
from schemas import UserSignup, User
from database import database

quizard_subscriptions = APIRouter()

@quizard_subscriptions.post("/successPayment")
async def successedPayment(response:Response, data:dict = Body(...)):
    try:
        response = await database.paymentSuccesseful(email=data["email"], memberShipPlan=data["plan"])
        return response
    except Exception as e:
        response.status_code = status.HTTP_403_FORBIDDEN
        return e.args
