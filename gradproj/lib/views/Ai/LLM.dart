import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/views/Ai/components.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';
import 'package:lottie/lottie.dart';

class LLM extends StatelessWidget {
  const LLM({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<LLMModelCubit, States>(builder: (context, state) {
      return Scaffold(
        backgroundColor: themeData.primaryColor,
        appBar: quizardAppBar(context),
        drawer: screenWidth < 800 ? const Drwr() : null,
        body: QuizardCubit.NUMBEROFGENS == 0 &&
                (QuizardCubit.MEMBERSHIP != "PRO" &&
                    QuizardCubit.MEMBERSHIP != "Q-PRO")
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/dead.json", width: 150),
                    const Text(
                      "Sorry! You ran out of exams please renew your subscription",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            : centeredView(
                child: Row(
                  children: [
                    MediaQuery.sizeOf(context).width > 800
                        ? Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: FutureBuilder(
                                  future:
                                      LLMModelCubit.GET(context).UserHistory,
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.separated(
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) => Scaffold(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              body: Center(
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width /
                                                                      1.2,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height /
                                                                      1.4,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border.all(
                                                                          width:
                                                                              4,
                                                                          color: themeData
                                                                              .primaryColor),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Text(
                                                                            "${snapshot.data.data[index]["exam"]}"),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Text("Exit View Of Exam")),
                                                                            IconButton(
                                                                                onPressed: () {
                                                                                  LLMModelCubit.GET(context).downloadPDF(snapshot.data.data[index]["exam"], snapshot.data.data[index]["title"], false);
                                                                                },
                                                                                icon: Icon(Icons.download))
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ));
                                              },
                                              child: Text(
                                                  "${snapshot.data.data[index]["title"]}"),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: 10,
                                              ),
                                          itemCount: snapshot.data.data.length);
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }),
                            ),
                          )
                        : SizedBox(),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: WebFileSelector(
                                multiple: false,
                                accept: ".pdf",
                                onData: (f) {
                                  pickedFileBytes = f.first;
                                  isPicked = true;
                                  isGenerated = false;
                                  LLMModelCubit.GET(context)
                                      .emit(UpdateLoading());
                                  print(pickedFileBytes!.name);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: Text(
                                      "Press to pick your PDF",
                                      style: TextStyle(
                                          color: themeData.primaryColor,
                                          fontSize: 20),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          isPicked
                              ? Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'File Name: ${pickedFileBytes!.name}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: fileTypeCountMap.entries
                                                .map((entry) {
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
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 10),
                                                    TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: entry.key,
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        fileTypeCountMap[
                                                                entry.key] =
                                                            int.tryParse(
                                                                    value) ??
                                                                0;
                                                      },
                                                    ),
                                                    SizedBox(height: 20),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          isGenerating
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : FutureBuilder(
                                                  future: pickedFileBytes!
                                                      .readAsBytes(),
                                                  builder: (cotext, ss) {
                                                    if (ss.hasData) {
                                                      return Container(
                                                          width:
                                                              double.infinity,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              // Implement generate functionality
                                                              await LLMModelCubit
                                                                      .GET(
                                                                          context)
                                                                  .generateQuizNow(
                                                                      ss.data
                                                                          as Uint8List,
                                                                      pickedFileBytes!
                                                                          .name);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  themeData
                                                                      .primaryColor,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          16),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              isGenerated &&
                                                                      response!
                                                                              .statusCode ==
                                                                          200
                                                                  ? "Generate Again"
                                                                  : 'Generate',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ));
                                                    } else {
                                                      return Text("loading");
                                                    }
                                                  }),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          isGenerated &&
                                                  response!.statusCode == 200
                                              ? Container(
                                                  width: double.infinity,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            // Implement viewing exam functionality
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Scaffold(
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          body:
                                                                              Center(
                                                                            child:
                                                                                Container(
                                                                              padding: EdgeInsets.all(10),
                                                                              width: MediaQuery.sizeOf(context).width / 1.2,
                                                                              height: MediaQuery.sizeOf(context).height / 1.4,
                                                                              decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 4, color: themeData.primaryColor), borderRadius: BorderRadius.circular(20)),
                                                                              child: SingleChildScrollView(
                                                                                child: Column(
                                                                                  children: [
                                                                                    Text("${response!.data}"),
                                                                                    SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    TextButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Text("Exit View Of Exam"))
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ));
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                themeData
                                                                    .primaryColor,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        16),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'View Exam',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            // Implement downloading functionality
                                                            await LLMModelCubit
                                                                    .GET(
                                                                        context)
                                                                .downloadPDF(
                                                                    response!
                                                                        .data,
                                                                    pickedFileBytes!
                                                                        .name,
                                                                    true)
                                                                .then((onValue) =>
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        "/home"));
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                themeData
                                                                    .primaryColor,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        16),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'Download Now',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(height: 20),
                          MediaQuery.sizeOf(context).width < 800
                              ? Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: FutureBuilder(
                                        future: LLMModelCubit.GET(context)
                                            .UserHistory,
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.separated(
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                                  Scaffold(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    body:
                                                                        Center(
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(10),
                                                                        width: MediaQuery.sizeOf(context).width /
                                                                            1.2,
                                                                        height: MediaQuery.sizeOf(context).height /
                                                                            1.4,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            border: Border.all(width: 4, color: themeData.primaryColor),
                                                                            borderRadius: BorderRadius.circular(20)),
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text("${snapshot.data.data[index]["exam"]}"),
                                                                              SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: [
                                                                                  TextButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text("Exit View Of Exam")),
                                                                                  IconButton(
                                                                                      onPressed: () {
                                                                                        LLMModelCubit.GET(context).downloadPDF(snapshot.data.data[index]["exam"], snapshot.data.data[index]["title"], false);
                                                                                      },
                                                                                      icon: Icon(Icons.download))
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ));
                                                    },
                                                    child: Text(
                                                        "${snapshot.data.data[index]["title"]}"),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                itemCount:
                                                    snapshot.data.data.length);
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
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
