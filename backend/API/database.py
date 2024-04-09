import pymongo.collection
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from backend.API.functions import Functions
from backend.API.schemas import UserSignup, User
import pymongo
import asyncio

class Database:
    def __init__(self):
        uri = "mongodb+srv://saifelbob2002:Saif%402002@quizard.aqpcddj.mongodb.net/?retryWrites=true&w=majority&appName=quizard"
        try:
            self.database = MongoClient(uri, server_api=ServerApi('1'))
            print("Database has been initialized")
        except Exception:
            print("Error")
    def get_users(self) -> pymongo.collection.Collection:
        return self.database["Quizard"]['Users']
    async def get_documents(self):
        return self.database["Quizard"]['Documents']
    async def get_history(self):
        return self.database["Quizard"]['History']

    async def sign_up(self, userSignup: UserSignup) -> bool:
        userSignup.password = Functions.hashPassword(userSignup.password)
        try:
            self.database["Quizard"]["Users"].insert_one(userSignup.dict())
            return Functions.getToken(userSignup.dict())
        except Exception as e:
            raise Exception("Can't add user, try again later")
    
    async def log_in(self, userLogin:User):
        userLogin.password = Functions.hashPassword(userLogin.password)
        try:
            userData = self.database["Quizard"]["Users"].find_one(userLogin.dict())
            if userData == None:
                raise Exception("Error user email or password")       
            return {"token":Functions.getToken(userLogin.dict()), "user_data":userData.__dict__}
        except Exception as e:
            raise e  

    async def forget_password(self, email:str, newPassword:str):
        if Functions.isPasswordStrong(newPassword):
            users = self.get_users()
            user = users.find_one({"email":email})
            if user != None:
                users.update_one(filter=user, update={"$set":{"password":Functions.hashPassword(newPassword)}})
                return True
            raise Exception("E-mail doesn't exist")
        raise Exception("Password is weak")


database = Database() #initialize database
