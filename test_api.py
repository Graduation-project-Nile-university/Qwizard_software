import requests

generate_question = requests.post("http://127.0.0.1:8000/generate_question", data={"context":"djfhdj"})
print(generate_question)