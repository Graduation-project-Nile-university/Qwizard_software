import 'package:flutter/material.dart';
import 'package:gradproj/views/subscriptions/individual.dart';
import 'package:gradproj/views/subscriptions/organization.dart';
// import 'package:gradproj/views/trialPage/trialPage.dart';
import 'package:gradproj/views/home/HomeView.dart';


class subscriptions extends StatelessWidget {
  const subscriptions({Key? key}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 191, 0),
                  Color.fromARGB(255, 141, 4, 141),
                ]
                ,tileMode: TileMode.repeated
              ),
            ),  
        child:
        SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                child:             
                TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView()));},
                       child:  Image.asset('assets/logo.png'), 
                        ),
                        ), 
              SizedBox(height: 100,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 100,),
                Container( 
                    height: 300,
                    width: 1050,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start  ,
                      children: <Widget>[
                          SizedBox(height: 50,),
                          Text(
                        "SUBSCRIPTIONS",
                        style: TextStyle(fontWeight: FontWeight.w900, height: 0.9, fontSize: 40, color: Colors.purple[800]),
                        ),
                        SizedBox(height: 50,),
    
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Container(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                        decoration: BoxDecoration(color: Colors.purple[800],
                        borderRadius: BorderRadius.circular(10)),
                        child:       
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>individual()));},
                           child: 
                           Text(
                           "Individuals",
                            style: TextStyle(
                            fontSize: 25, 
                            fontWeight: FontWeight.w800, 
                            color: Colors.white),
                            ),
                            ),
                                ],
                              ),           
                              ),
                              SizedBox(width: 50,),
    
                              Container(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                        decoration: BoxDecoration(color: Colors.purple[800],
                        borderRadius: BorderRadius.circular(10)),
                        child:       
                              Row(
                                children: [
                                  TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> organization()));},
                           child: 
                           Text(
                           "Organizations",
                            style: TextStyle(
                            fontSize: 25, 
                            fontWeight: FontWeight.w800, 
                            color: Colors.white),
                            ),
                            ),
                                ],
                              ),           
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          
        ),
        ),
      ),
    );
  }
}