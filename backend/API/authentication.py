from fastapi import Body, APIRouter, Response, status
from functions import Functions
from schemas import UserSignup, User
from database import database

authentication = APIRouter()

@authentication.post("/authentication/signup")
async def signUp(response: Response, userSignupData: UserSignup):
    if Functions.isPasswordStrong(userSignupData.password):
        try:
            data = await database.sign_up(userSignupData)
            return {"token":data["token"], "userData":data["data"]}
        except Exception as e:
            response.status_code = status.HTTP_403_FORBIDDEN
            return {"failure":e.args}
    else:
        response.status_code = status.HTTP_406_NOT_ACCEPTABLE
        return {"failure":"Password is weak"}
    

@authentication.post("/authentication/login")
async def logIn(response:Response, userLogin: User):
    try:
        responseData = await database.log_in(userLogin)
        return responseData
    except Exception as e:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {"failure":e.args}

@authentication.post("/authentication/changePassword")
async def changePassword(response:Response, data: dict = Body(...)):
    try:
        await database.change_password(data["email"], data["new_password"])
        return {"success":"Password resetted successfully"}
    except Exception as e:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {"failure": e.args}
    
@authentication.post("/authentication/forgetPassword")
async def forgetPassword(response:Response, data: dict=Body(...)):
    try: 
        otp = await database.forget_password(data["email"])
        return {"otp":otp}
    except Exception as e:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {"failure":e.args}
