import 'package:flutter/material.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';
import 'package:gradproj/widgets/navigationBar/navigationBar.dart';
// import 'package:gradproj/views/home/HomeView.dart';
// import 'package:stroke_text/stroke_text.dart';



class individual extends StatelessWidget {
  const individual({Key? key}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: navigationBar(),backgroundColor: Color.fromARGB(255, 141, 4, 141), toolbarHeight: 110,),
      body:centeredView(
      child: Container(
        decoration: BoxDecoration( borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            SizedBox(width: 50,),
            Container(
              decoration: BoxDecoration(color:  Color.fromARGB(255, 255, 246, 222), borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 
                    Container(
                      height: 50,
                      child: Text("FREE", style: TextStyle(fontWeight: FontWeight.w900, height: 0.9, fontSize: 25, color: Colors.purple[800]))),
                      SizedBox(height: 25,),
                      Text("1 user", style: TextStyle(fontWeight: FontWeight.w100, height: 0.9, fontSize: 15, color: Color.fromARGB(255, 255, 191, 0))),
                      SizedBox(height: 30,),
                      Text("1 exam", style: TextStyle(fontWeight: FontWeight.w100, height: 0.9, fontSize: 15, color: Color.fromARGB(255, 255, 191, 0))),
                      SizedBox(height: 30,),
                      Text("15 questions", style: TextStyle(fontWeight: FontWeight.w100, height: 0.9, fontSize: 15, color: Color.fromARGB(255, 255, 191, 0))),
                      SizedBox(height: 30,),
                      Text("-", style: TextStyle(fontWeight: FontWeight.w100, height: 0.9, fontSize: 15, color: Color.fromARGB(255, 255, 191, 0))),
                      SizedBox(height: 50,),
                      TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>individual()));},
                           child: 
                           Text(
                           "Purchase",
                            style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.w400, 
                            color: Colors.purple[800]),
                            ),
                            ),
                ],
              ),
            ),
            SizedBox(width: 100,),
            Container(
              decoration: BoxDecoration(color:  Color.fromARGB(255, 255, 236, 178), borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Container(
                      height: 50,
                      child: 
                      Text("BASIC", style: TextStyle(fontWeight: FontWeight.w900, height: 0.9, fontSize: 25, color: Colors.purple[800]))),
                      SizedBox(height: 25,),
                      Text("1 user", style: TextStyle(fontWeight: FontWeight.w100, height: 0.9, fontSize: 15, color: Color.fromARGB(255, 255, 191, 0),)),
                      SizedBox(height: 30,),
                      Text("5 exams/week", style: TextStyle(fontWeight: FontWeight.w100, height: 0.9, fontSize: 15, color: Color.fromARGB(255, 255, 191, 0))),
                      SizedBox(height: 30,),
                      Text("Limited question types", style: TextStyle(fontWeight: FontWeight.w100, height: 0.9, fontSize: 15, color: Color.fromARGB(255, 255, 191, 0))),
                      SizedBox(height: 30,),
                      Text("-", style: TextStyle(fontWeight: FontWeight.w100, height: 0.9, fontSize: 15, color: Color.fromARGB(255, 255, 191, 0))),
                      SizedBox(height: 50,),
                      TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>individual()));},
                           child: 
                           Text(
                           "Purchase",
                            style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.w400, 
                            color: Colors.purple[800]),
                            ),
                            ),
                ],
              ),
            ),
            SizedBox(width: 100,),
            Container(
              decoration: BoxDecoration(color:  Color.fromARGB(255, 255, 228, 148), borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Container(
                      height: 50,
                      child: Text("PRO", style: TextStyle(fontWeight: FontWeight.w900, height: 0.9, fontSize: 25, color: Colors.purple[800]))),
                      SizedBox(height: 25,),
                      Text("2 user", style: TextStyle(fontWeight: FontWeight.w100, height: 0.9, fontSize: 15, color: Color.fromARGB(255, 255, 191, 0))),
                      SizedBox(height: 30,),
                      Text("Unlimited exams", style: TextStyle(fontWeight: FontWeight.w100, height: 0.9, fontSize: 15, color: Color.fromARGB(255, 255, 191, 0))),
                      SizedBox(height: 30,),
                      Text("Unlimited question types", style: TextStyle(fontWeight: FontWeight.w100, height: 0.9, fontSize: 15, color: Color.fromARGB(255, 255, 191, 0))),
                      SizedBox(height: 30,),
                      Text("Question customization", style: TextStyle(fontWeight: FontWeight.w100, height: 0.9, fontSize: 15, color: Color.fromARGB(255, 255, 191, 0))),
                      SizedBox(height: 50,),
                      TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>individual()));},
                           child: 
                           Text(
                           "Purchase",
                            style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.w400, 
                            color: Colors.purple[800]),
                            ),
                            ),
                ],
              ),
            ),
            SizedBox(width: 50,),
          
          ],
        ),
      ),
      ),
    );
  }
}