import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';
import 'package:gradproj/widgets/navigationBar/navigationBar.dart';

Future generate_QA(String context) async {
  var data = await Dio().post("http://10.2.149.87:8000/generate_QA",
      data: {"context": context},
      options: Options(headers: {"Access-Control-Allow-Origin": "*"}));
  return data.data;
}

class MLModel extends StatefulWidget {
  const MLModel({super.key});

  @override
  State<MLModel> createState() => _MLModelState();
}

TextEditingController contextText = TextEditingController();
String questionResult = "";
String answerResult = "";
bool isLoading = false;

class _MLModelState extends State<MLModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: navigationBar(),
          backgroundColor: Color.fromARGB(255, 141, 4, 141),
          toolbarHeight: 110,
        ),
        body: centeredView(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextField(
                  controller: contextText,
                  maxLines: 7,
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple[800])),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await generate_QA(contextText.text).then((value) {
                            print(value);
                            setState(() {
                              isLoading = false;
                              questionResult = value["question"];
                              answerResult = value["answer"];
                            });
                          });
                        },
                        child: Text(
                          "Generate Q and A",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                Text("Q - $questionResult \n",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("A - $answerResult",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ));
  }
}
