import 'package:flutter/material.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:gradproj/widgets/navigationBar/navigationBar.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';
import 'package:gradproj/widgets/homeBody/homeBody.dart';
import 'package:gradproj/widgets/trial/trial.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
 @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    final swidth = MediaQuery.of(context).size.width;
    return swidth <850? 
      Scaffold(
      appBar: AppBar(
        title: const Text("Quizard"),
        backgroundColor: Color.fromARGB(255, 141, 4, 141),
        )
      ,
      drawer: const Drwr(),
      body: const centeredView(
        child: homeBody(),
      ),
    )


    : 
    
    
    Scaffold(
      appBar: AppBar(
        title: navigationBar(),
        backgroundColor: Color.fromARGB(255, 141, 4, 141),
        toolbarHeight: 110,
      ),
      body: const centeredView(
        child: homeBody(),
      ),
    );
  }
}
