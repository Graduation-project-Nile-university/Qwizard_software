from fastapi import APIRouter, Body, status, Response, FastAPI
from transformers import AutoModelWithLMHead, AutoTokenizer

qwizard = FastAPI()

tokenizer_t5base = AutoTokenizer.from_pretrained("mrm8488/t5-base-finetuned-question-generation-ap")
model_t5base = AutoModelWithLMHead.from_pretrained("mrm8488/t5-base-finetuned-question-generation-ap")


@qwizard.post("/home")
def t5_QA(params: dict=Body(...)):
    input_text = "answer: %s  context: %s </s>" % (params["answer"], params["context"])
    features = tokenizer_t5base([input_text], return_tensors='pt')

    output = model_t5base.generate(input_ids=features['input_ids'], 
                attention_mask=features['attention_mask'],
                max_length=64)

    return tokenizer_t5base.decode(output[0])


