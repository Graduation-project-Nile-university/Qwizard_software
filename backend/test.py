import requests

firstApproach = requests.post("""http://192.168.1.6:8000/generateExam2""", files={"pdf":open("C:\\Users\\Saif\\Desktop\\Qwizard software\\Qwizard_software\\backend\\shoaib.pdf", "rb")})
# secondApproach = requests.post("""http://192.168.1.6:8000/generateExam2""", files={"pdf":open("file.pdf", "rb")})


print(firstApproach.content)