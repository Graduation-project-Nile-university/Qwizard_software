from schemas import History
from functions import Functions
from fastapi import APIRouter, Body, status, Response, FastAPI, UploadFile, File, Request
from bs4 import BeautifulSoup
import fitz
from database import database
# from transformers import AutoModelForQuestionAnswering, AutoTokenizer, pipeline
# from langchain.embeddings import HuggingFaceEmbeddings
# from langchain.chains.question_answering import load_qa_chain
# from langchain.schema.runnable import RunnablePassthrough
# from langchain.prompts import PromptTemplate
# from langchain.document_loaders import PyPDFLoader
# from langchain.text_splitter import CharacterTextSplitter
# from langchain.vectorstores import Chroma
# from langchain.schema import StrOutputParser
# import joblib
# import json
# import re
# from pprint import pprint
# import pandas as pd
# import torch
# # from datasets import Dataset, load_dataset
# from huggingface_hub import notebook_login
# # from peft import LoraConfig, PeftModel
# from transformers import (
#     AutoModelForCausalLM,
#     AutoTokenizer,
#     BitsAndBytesConfig,
#     TrainingArguments,
# )
# import warnings
# warnings.filterwarnings('ignore')
# from transformers import pipeline
# from transformers import AutoModelForCausalLM, AutoTokenizer, TextStreamer, BitsAndBytesConfig
# import torch
# import torch
# from PyPDF2 import PdfReader
# from langchain_huggingface.llms import HuggingFacePipeline
# from transformers import AutoModelForCausalLM, AutoTokenizer, pipeline
# from langchain_core.prompts import PromptTemplate
# from langchain_chroma.vectorstores import Chroma  # Assumisng Chroma is accessible from langchain_chroma
# import os
# from tigerscore import TIGERScorer
# # from trl import SFTTrainer
# DEVICE = "cuda:0" if torch.cuda.is_available() else "cpu"
# print(DEVICE)


qwizard_model = APIRouter()


@qwizard_model.post("/updateNumOfGens")
async def update_num_of_gens(response: Response,token:Request, data:History):
    try:
        email = token.headers["email"]
        await database.update_num_of_gens(email)
        database.add_to_history(data, email)
        return {"success":"Updated successfully"}
    except Exception as e:
        print(e.args)
        response.status_code = status.HTTP_403_FORBIDDEN
        return {"failure":e.args} 

@qwizard_model.get("/{email}/getUserHistory")
def getUserHistory(response: Response, email:str):
    try:
        history = []
        for i in database.get_history(email).find():
            i["_id"] = str(i["_id"])
            history.append(i)
        return history
    except Exception as e:
        response.status_code = status.HTTP_403_FORBIDDEN
        return e
        

@qwizard_model.post("/generateExam")
async def preprocess_pdf_and_generate(response: Response, pdf: UploadFile = File()): 
    try:
        html_content = ""
        divs_included_images = []
        images_with_description_in_pdf = []

        
        doc = fitz.open(stream = pdf.file.read(), filetype="pdf")
        for page_num in range(doc.page_count):
            page = doc[page_num]
            html_content += page.get_text("html")

        file = BeautifulSoup(html_content, "html.parser")
        print(file)
        divs = file.findAll("div")
        for div in divs:
            if div.findAll("img").__len__() > 0:
                divs_included_images.append(div)

        for div in divs_included_images:
            now = "p"
            for i in div:
                if i.name == "img":
                    images_with_description_in_pdf.append(Functions.convert_image_to_text(i.attrs["src"]))
                    now = "img"
                elif i.name == "p" and now=="img":
                    images_with_description_in_pdf.append(i.text)
                    now="p"

        textInFile = file.text
        for i in range(1, len(images_with_description_in_pdf), 2):
            textInFile = textInFile.replace(images_with_description_in_pdf[i], " image: "+images_with_description_in_pdf[i-1])
        return textInFile
    except Exception as e:
        return e.args
#     try:
#         ###################### CHANGE YOUR MODEL FROM HERE ###########################################
#         bnb_config = BitsAndBytesConfig(
#             load_in_4bit=True,
#             bnb_4bit_use_double_quant=True,
#             bnb_4bit_quant_type="nf4",
#             bnb_4bit_compute_dtype=torch.bfloat16
#         )
#         device = 'cuda' if torch.cuda.is_available() else 'cpu'

#         # set up scorer
#         scorer = TIGERScorer(model_name="TIGER-Lab/TIGERScore-7B", quantized=True) # 4 bit quantization on GPU

#         # Initialize and setup LangChain with Llama Index agents
#         model_id = "meta-llama/Meta-Llama-3-8B-Instruct"
#         tokenizer = AutoTokenizer.from_pretrained(model_id)
#         model = AutoModelForCausalLM.from_pretrained(model_id,
#                                                     torch_dtype=torch.bfloat16,  # Specify the compute dtype
#                                                     low_cpu_mem_usage=True,      # Use efficient memory handling
#                                                     device_map="auto",           # Automatically map the model to the available device
#                                                     load_in_4bit=bnb_config.load_in_4bit,  # Enable 4-bit quantization
#                                                     bnb_4bit_use_double_quant=bnb_config.bnb_4bit_use_double_quant,
#                                                     bnb_4bit_quant_type=bnb_config.bnb_4bit_quant_type,
#                                                     bnb_4bit_compute_dtype=bnb_config.bnb_4bit_compute_dtype)

#         text_generation_pipeline = pipeline("text-generation", model=model, tokenizer=tokenizer, max_new_tokens=2128)
#         llm = HuggingFacePipeline(pipeline=text_generation_pipeline)

#         text_splitter = CharacterTextSplitter(
#         separator="\n",
#         chunk_size=500,
#         chunk_overlap=20,
#         length_function=len,
#         )
#         # Split text and prepare embeddings
#         texts = text_splitter.split_text(textInFile)

#         embeddings_file = "path_to_embeddings.joblib"
#         if os.path.exists(embeddings_file):
#             embeddings = joblib.load(embeddings_file)
#         else:
#             embeddings = HuggingFaceEmbeddings()
#             joblib.dump(embeddings, embeddings_file)

#         vectorstore = Chroma.from_texts(texts, embeddings)

#         # Create a retriever
#         retriever = vectorstore.as_retriever()

#         # Generate Exam
#         def generate_exam(query):
#             # Create prompt from template
#             prompt_template = """
#             <s>[INST] <<SYS>>
#             You are a helpful AI exam generator.
#             Generate a solved exam based on the context provided. Be concise and just include the exam generated.
#             <</SYS>>
#             {context}
#             Question: {question}
#             Helpful Answer: [/INST]
#             """
#             prompt = PromptTemplate.from_template(prompt_template)

#             # Chain construction
#             chain = (
#                 {"context": retriever, "question": RunnablePassthrough()}  # Ensure retriever.retrieve is used correctly
#                 | prompt
#                 | llm
#             )
#             exam_text = chain.invoke(query)
#             return exam_text, retriever, textInFile

#         # Evaluate Exam
#         def evaluate_exam(instruction, input_context, hypo_output):
#             scorer = TIGERScorer(model_name="TIGER-Lab/TIGERScore-7B") # 4 bit quantization on GPU
#             results = scorer.score([instruction], [hypo_output], [input_context])
#             return results

#         # Feedback Loop to Correct Exam
#         def correct_exam(exam_text, raw_text):
#             # Evaluate initial exam
#             evaluation_results = evaluate_exam("Please evaluate the following exam", raw_text, exam_text)
#             errors = [result['errors'] for result in evaluation_results if 'errors' in result]
#             if not errors:
#                 return exam_text  # No errors found, return original exam

#             # Generate a correction prompt including errors
#             correction_query = f"Correct the following exam which is: {original_exam}. based on these errors: {errors}, and here is the content that the exam was made from {retriever}"
#             corrected_exam = generate_exam(correction_query)
#             return corrected_exam

#         # Example usage
#         original_exam = generate_exam("generate me an exam with several question types about auto parellelization ")
#         corrected_exam = correct_exam(original_exam, retriever)

#         def format_exam(exam_text):
#             # Assuming questions are separated by the word "Question:"
#             questions = exam_text.split("Question:")
#             formatted_exam = "\n".join(f"Question {i}: {q.strip()}" for i, q in enumerate(questions) if q)
#             return formatted_exam
        
#         print("Original Exam:\n", format_exam(original_exam[0]))
#         print("\nCorrected Exam:\n", format_exam(corrected_exam[0]))

#         return format_exam(corrected_exam[0])
#     ################################## TO HERE ###########################################################

#     except Exception as e:
#         return e.args






@qwizard_model.post("/generateExam2")
async def preprocess_pdf_and_generate2(response: Response, pdf: UploadFile = File()): 
    try:
        html_content = ""
        divs_included_images = []
        images_in_pdf = []

        
        doc = fitz.open(stream = pdf.file.read(), filetype="pdf")
        for page_num in range(doc.page_count):
            page = doc[page_num]
            html_content += page.get_text("html")

        file = BeautifulSoup(html_content, "html.parser")

        divs = file.findAll("div")
        for div in divs:
            if div.findAll("img").__len__() > 0:
                divs_included_images.append(div)

        for div in divs_included_images:
            for i in div:
                if i.name == "img":
                    images_in_pdf.append(i.attrs["src"])

        if images_in_pdf.__len__() > 0:
            images_descriptions = Functions.convert_image_to_text(images_in_pdf)
            textInFile = file.text
            textInFile += images_descriptions
        else:
            textInFile = file.text
        return textInFile
    except Exception as e:
        response.status_code = status.HTTP_403_FORBIDDEN
        return e.args
    
#     try:
#         ###################### CHANGE YOUR MODEL FROM HERE ###########################################

#         bnb_config = BitsAndBytesConfig(
#             load_in_4bit=True,
#             bnb_4bit_use_double_quant=True,
#             bnb_4bit_quant_type="nf4",
#             bnb_4bit_compute_dtype=torch.bfloat16
#         )
#         device = 'cuda' if torch.cuda.is_available() else 'cpu'

#         # set up scorer
#         scorer = TIGERScorer(model_name="TIGER-Lab/TIGERScore-7B", quantized=True) # 4 bit quantization on GPU

#         # Initialize and setup LangChain with Llama Index agents
#         model_id = "meta-llama/Meta-Llama-3-8B-Instruct"
#         tokenizer = AutoTokenizer.from_pretrained(model_id)
#         model = AutoModelForCausalLM.from_pretrained(model_id,
#                                                     torch_dtype=torch.bfloat16,  # Specify the compute dtype
#                                                     low_cpu_mem_usage=True,      # Use efficient memory handling
#                                                     device_map="auto",           # Automatically map the model to the available device
#                                                     load_in_4bit=bnb_config.load_in_4bit,  # Enable 4-bit quantization
#                                                     bnb_4bit_use_double_quant=bnb_config.bnb_4bit_use_double_quant,
#                                                     bnb_4bit_quant_type=bnb_config.bnb_4bit_quant_type,
#                                                     bnb_4bit_compute_dtype=bnb_config.bnb_4bit_compute_dtype)

#         text_generation_pipeline = pipeline("text-generation", model=model, tokenizer=tokenizer, max_new_tokens=2128)
#         llm = HuggingFacePipeline(pipeline=text_generation_pipeline)

#         text_splitter = CharacterTextSplitter(
#         separator="\n",
#         chunk_size=500,
#         chunk_overlap=20,
#         length_function=len,
#         )
#         # Split text and prepare embeddings
#         texts = text_splitter.split_text(textInFile)

#         embeddings_file = "path_to_embeddings.joblib"
#         if os.path.exists(embeddings_file):
#             embeddings = joblib.load(embeddings_file)
#         else:
#             embeddings = HuggingFaceEmbeddings()
#             joblib.dump(embeddings, embeddings_file)

#         vectorstore = Chroma.from_texts(texts, embeddings)

#         # Create a retriever
#         retriever = vectorstore.as_retriever()

#         # Generate Exam
#         def generate_exam(query):
#             # Create prompt from template
#             prompt_template = """
#             <s>[INST] <<SYS>>
#             You are a helpful AI exam generator.
#             Generate a solved exam based on the context provided. Be concise and just include the exam generated.
#             <</SYS>>
#             {context}
#             Question: {question}
#             Helpful Answer: [/INST]
#             """
#             prompt = PromptTemplate.from_template(prompt_template)

#             # Chain construction
#             chain = (
#                 {"context": retriever, "question": RunnablePassthrough()}  # Ensure retriever.retrieve is used correctly
#                 | prompt
#                 | llm
#             )
#             exam_text = chain.invoke(query)
#             return exam_text, retriever, textInFile

#         # Evaluate Exam
#         def evaluate_exam(instruction, input_context, hypo_output):
#             scorer = TIGERScorer(model_name="TIGER-Lab/TIGERScore-7B") # 4 bit quantization on GPU
#             results = scorer.score([instruction], [hypo_output], [input_context])
#             return results

#         # Feedback Loop to Correct Exam
#         def correct_exam(exam_text, raw_text):
#             # Evaluate initial exam
#             evaluation_results = evaluate_exam("Please evaluate the following exam", raw_text, exam_text)
#             errors = [result['errors'] for result in evaluation_results if 'errors' in result]
#             if not errors:
#                 return exam_text  # No errors found, return original exam

#             # Generate a correction prompt including errors
#             correction_query = f"Correct the following exam which is: {original_exam}. based on these errors: {errors}, and here is the content that the exam was made from {retriever}"
#             corrected_exam = generate_exam(correction_query)
#             return corrected_exam

#         # Example usage
#         original_exam = generate_exam("generate me an exam with several question types about auto parellelization ")
#         corrected_exam = correct_exam(original_exam, retriever)

#         def format_exam(exam_text):
#             # Assuming questions are separated by the word "Question:"
#             questions = exam_text.split("Question:")
#             formatted_exam = "\n".join(f"Question {i}: {q.strip()}" for i, q in enumerate(questions) if q)
#             return formatted_exam
        
#         print("Original Exam:\n", format_exam(original_exam[0]))
#         print("\nCorrected Exam:\n", format_exam(corrected_exam[0]))

#         return format_exam(corrected_exam[0])
#     ################################## TO HERE ###########################################################

#     except Exception as e:
#         return e.args



