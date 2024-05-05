import 'package:flutter/material.dart';
import 'package:gradproj/views/home/HomeView.dart';
import 'package:gradproj/views/profile/profileEdit.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/widgets/navigationBar/navigationBar.dart';

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context ) {
    return Scaffold(
      appBar: AppBar(
        title: QuizardCubit.USERTOKEN == null
            ? Text("Profile", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,),)
            : Text("Welcome, ${QuizardCubit.USERNAME}"),
        backgroundColor: Color.fromARGB(255, 141, 4, 141),
      ),
      drawer: const Drwr(),

      body: centeredView(
        child: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15 ),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text("Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                SizedBox(height: 50,),
                Text("Phone number", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 50,),
                Text("Email", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 70,),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => profileEdit()));
                    }, child: Text("Edit", style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 141, 4, 141),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    )
                  ],
                )
              ]
            ),
            )
        ),
      ),
    );

}
}
