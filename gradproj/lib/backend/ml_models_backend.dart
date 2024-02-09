import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future test_ML_model(String context, String answer) async {
  var data = await Dio().post("http://192.168.1.24:8000/home",
      data: {"context": context, "answer": answer},
      options: Options(headers: {"Access-Control-Allow-Origin": "*"}));
  return data.data;
}

class MLModel extends StatefulWidget {
  const MLModel({super.key});

  @override
  State<MLModel> createState() => _MLModelState();
}

TextEditingController contextText = TextEditingController();
TextEditingController answer = TextEditingController();
String question = "";

class _MLModelState extends State<MLModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: contextText,
          ),
          TextField(
            controller: answer,
          ),
          ElevatedButton(
              onPressed: () async {
                await test_ML_model(contextText.text, answer.text)
                    .then((value) {
                  setState(() {
                    question = value;
                  });
                });
              },
              child: Text("Generate Question")),
          Text(question)
        ],
      ),
    );
  }
}
