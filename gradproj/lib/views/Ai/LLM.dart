import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/views/Ai/components.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';

class LLM extends StatelessWidget {
  const LLM({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<LLMModelCubit, States>(builder: (context, state) {
      return Scaffold(
        appBar: quizardAppBar(context),
        drawer: screenWidth < 800 ? const Drwr() : null,
        body: centeredView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            await LLMModelCubit.GET(context).pickFile();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: themeData.primaryColor, width: 3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Pick PDF File',
                            style: TextStyle(color: themeData.primaryColor),
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20),
              isPicked
                  ? Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'File Name: ${pickedFileBytes!.files.first.name}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'File Size: ${(pickedFileBytes!.files.first.size / 1024).toStringAsFixed(2)} KB',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[700]),
                              ),
                              SizedBox(height: 20),
                              Text('Select Question Types:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildCheckbox('MCQ'),
                                  buildCheckbox('T&F'),
                                  buildCheckbox('Essay'),
                                ],
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: fileTypeCountMap.entries.map((entry) {
                                  return Visibility(
                                    visible: entry.value > 0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Enter number of ${entry.key} questions:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: entry.key,
                                            border: OutlineInputBorder(),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            fileTypeCountMap[entry.key] =
                                                int.tryParse(value) ?? 0;
                                          },
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                              isGenerating
                                  ? CircularProgressIndicator()
                                  : Container(
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          // Implement generate functionality
                                          await LLMModelCubit.GET(context)
                                              .generateQuizNow(
                                                  pickedFileBytes!.files.first
                                                      .bytes as Uint8List,
                                                  pickedFileBytes!
                                                      .files.first.name);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              themeData.primaryColor,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          'Generate',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    });
  }

  Widget buildCheckbox(String fileType) {
    return BlocBuilder<LLMModelCubit, States>(builder: (context, state) {
      return Row(
        children: [
          Checkbox(
            value: fileTypeCountMap.containsKey(fileType) &&
                fileTypeCountMap[fileType]! > 0,
            onChanged: (value) {
              if (value!) {
                fileTypeCountMap[fileType] = 1;
              } else {
                fileTypeCountMap.remove(fileType);
              }
              LLMModelCubit.GET(context).emit(UpdateLoading());
            },
          ),
          Text(fileType, style: TextStyle(fontSize: 16)),
          SizedBox(width: 10),
        ],
      );
    });
  }
}
