import pymongo.collection
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from functions import Functions
from schemas import History, UserSignup, User
import pymongo
import asyncio

class Database:
    def __init__(self):
        uri = "mongodb+srv://saifelbob2002:Saif%402002@quizard.aqpcddj.mongodb.net/?retryWrites=true&w=majority&appName=quizard"
        try:
            self.database = MongoClient(uri, server_api=ServerApi('1'))
            print("Database has been initialized")
        except Exception as error:
            print(error)
    def get_users(self):
        return self.database["Quizard"]['Users']
    def get_history(self, email:str):
        return self.database["Quizard"][email]

    async def sign_up(self, userSignup: UserSignup) -> bool:
        userSignup.password = Functions.hashPassword(userSignup.password)
        try:
            self.database["Quizard"]["Users"].insert_one(userSignup.dict())
            return {"data":userSignup.dict(), "token":Functions.getToken(userSignup.dict())}
        except Exception as e:
            raise Exception("Can't add user, try again later ")
    
    async def log_in(self, userLogin:User):
        try:
            for user in self.get_users().find():
                if Functions.verifyPassword(userLogin.password, user["password"]):
                    user["_id"] = str(user["_id"])
                    return {"token":Functions.getToken(userLogin.dict()), "user_data":user}
            raise Exception("Wrong user email or password ")       
        except Exception as e:
            raise e  

    async def change_password(self, email:str, newPassword:str):
        if Functions.isPasswordStrong(newPassword):
            users = self.get_users()
            user = users.find_one({"email":email})
            if user != None:
                users.update_one(filter=user, update={"$set":{"password":Functions.hashPassword(newPassword)}})
                return True
            raise Exception("E-mail doesn't exist")
        raise Exception("Password is weak")
     
    async def is_email_exists(self, email:str) -> bool:
        for user in self.get_users().find():
            if user["email"] == email:
                return True
        return False

    async def forget_password(self, email:str):
        if await self.is_email_exists(email):
            otp = Functions.forgotPasswordEmail(email)
            return otp
        else:
            raise Exception("There is no user exists with this email")
        
    async def paymentSuccesseful(self, email:str, memberShipPlan:str):
        try:
            if self.is_email_exists(email):
                data = self.get_users().update_one(filter={"email":email.strip()}, update={"$set":{"membershipPlan":memberShipPlan.strip(), "numOfGens":Functions.getNumOfGensOfPlan(memberShipPlan.strip())},})
                return {"success":"Your upgrade was successful", "numOfGens":Functions.getNumOfGensOfPlan(memberShipPlan.strip())}
            else:
                raise Exception("Email not exists")
        except Exception as e:
            raise Exception(e.args)
    
    async def update_num_of_gens(self, email:str):
        try:
            self.get_users().update_one(filter={"email":email.strip()}, update={"$inc": {"numOfGens": -1}})
            return True
        except Exception as e:
            print(e)
            raise Exception(f"Something error: {e.args}")
        
    def add_to_history(self, history:History ,email:str):
        try:
            self.get_history(email).insert_one(history.dict())
        except Exception as e :
            raise e

database = Database() #initialize database
