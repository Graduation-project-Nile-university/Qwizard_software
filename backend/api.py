from transformers import AutoModelWithLMHead, AutoTokenizer
from transformers import AutoTokenizer, BertForQuestionAnswering
from fastapi import APIRouter, Body, status, Response, FastAPI
from transformers import AutoTokenizer, AutoModelForSeq2SeqLM
from transformers import AutoModelForQuestionAnswering, AutoTokenizer, pipeline
import re

qwizard_models = APIRouter()

tokenizer = AutoTokenizer.from_pretrained("voidful/context-only-question-generator")
model = AutoModelForSeq2SeqLM.from_pretrained("voidful/context-only-question-generator")

tokenizer_roberta = AutoTokenizer.from_pretrained("deepset/roberta-base-squad2")
model_roberta = AutoModelForQuestionAnswering.from_pretrained("deepset/roberta-base-squad2")

@qwizard_models.post("/generate_QA")
def generate_QA(res: Response, params: dict=Body(...)):
    results = {"context":params["context"]}

    context = params["context"]
    
    tokenized_context = tokenizer(context, return_tensors="pt")
    question_encoded = model.generate(tokenized_context["input_ids"])
    question_decoded = tokenizer.decode(question_encoded[0])
    results["question"] = re.sub("</s>", "", question_decoded)

    inputs_encoded = tokenizer_roberta(results["question"], context, return_tensors="pt")
    generated_answer = model_roberta(**inputs_encoded)
    answer_start_index = generated_answer.start_logits.argmax()
    answer_end_index = generated_answer.end_logits.argmax()

    predict_answer_tokens = inputs_encoded.input_ids[0, answer_start_index: answer_end_index+1]
    predicted_answer = tokenizer_roberta.decode(predict_answer_tokens, skip_special_tokens=True)
    results["answer"] = predicted_answer
    return results

@qwizard_models.post("/generate_question")
def generate_question(res: Response, params: dict=Body(...)):
    context = params["context"]
    
    tokenized_context = tokenizer(context, return_tensors="pt")
    question_encoded = model.generate(tokenized_context["input_ids"])
    question_decoded = tokenizer.decode(question_encoded[0])
    return re.sub("</s>", "", question_decoded)


@qwizard_models.post("/answer_question")
def answer_question(res: Response, params: dict=Body(...)):
    context = params["context"]
    question = params["question"]

    inputs_encoded = tokenizer_roberta(question, context, return_tensors="pt")
    generated_answer = model_roberta(**inputs_encoded)
    answer_start_index = generated_answer.start_logits.argmax()
    answer_end_index = generated_answer.end_logits.argmax()

    predict_answer_tokens = inputs_encoded.input_ids[0, answer_start_index: answer_end_index+1]
    predicted_answer = tokenizer_roberta.decode(predict_answer_tokens, skip_special_tokens=True)
    
    return predicted_answer

