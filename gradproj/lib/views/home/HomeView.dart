import 'package:flutter/material.dart';
import 'package:gradproj/backend/ml_models_backend.dart';
import 'package:gradproj/views/aboutUs/aboutUs.dart';
import 'package:gradproj/views/logIn/logIn.dart';
import 'package:gradproj/views/signUp/signUp.dart';
import 'package:gradproj/views/subscriptions/subscriptions.dart';
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        )
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeView()));
              },
            ),
            ListTile(
              title: Text('Subscriptions'),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const subscriptions()));
              },
            ),
            ListTile(
              title: Text('Test'),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MLModel()));
              },
            ),
            ListTile(
              title: Text('Sign Up'),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const signUp()));
              },
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const logIn()));
              },
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => aboutUs()));
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(1, 1, 1, 1),
      body: centeredView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                homeBody(),
                trial("Try me"), 
          ],
        ),
      ),
    )


    : 
    
    
    Scaffold(
      appBar: AppBar(
        title: navigationBar(),
        backgroundColor: Color.fromARGB(255, 141, 4, 141),
        toolbarHeight: 110,
      ),
      backgroundColor: const Color.fromARGB(1, 1, 1, 1),
      body: centeredView(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Row(
              children: <Widget>[
                homeBody(),
                Center(
                  child: trial("  Try me  "),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
