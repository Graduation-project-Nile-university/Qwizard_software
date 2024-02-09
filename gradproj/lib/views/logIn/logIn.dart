import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradproj/views/inside/inside.dart';
import 'package:gradproj/views/home/HomeView.dart';



class logIn extends StatefulWidget {
 const logIn({super.key});
 @override
 State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {

 var EmailController = TextEditingController();
 var PasswordController = TextEditingController();
 

var formKey = GlobalKey<FormState>();

@override
Widget build(BuildContextcontext){
  return Scaffold(
    body: 
    Stack(
      children:[
        Container(
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
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Row(
              
              children: [
                Container(
                height: 50,
                child: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView()));},
                 child:  Image.asset('assets/logo.png'), 
                  ),
                  ), 
              SizedBox(width: 450,),

            const Text("LOG IN",
            style: TextStyle(color: Color.fromARGB(255, 141, 4, 141),
            fontSize: 40,
            fontWeight: FontWeight.w800,
            ),
            ),
              ],),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                  ),
                  child: Form(key: formKey,
                  child: Column(crossAxisAlignment:CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: EmailController,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (String value){
                        print(value);
                      },
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Email address must not be empty";
                        }
                        if(!value.contains("@"))
                        {
                          return "Email address is not valid";
                        }
                        return null;
                      },

                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email,
                        ),
                        prefixIconColor: Color.fromARGB(255, 141, 4, 141),
                        labelText: "Email Address",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: PasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isnotSeenPassword,
                      onFieldSubmitted: (String value) {
                        print (value);
                      },
                      validator: (value)
                      {
                         if(value!.isEmpty)
                         {
                          return "Password must not be empty";
                         }
                         if(!value.contains("@") && !value.contains("_"))
                         {
                          return "password must contain a special character";
                         }
                         return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.password
                        ),
                        prefixIconColor: const Color.fromARGB(255, 141, 4, 141),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            isnotSeenPassword = !isnotSeenPassword;
                          });
                        },
                        icon: Icon(
                          isnotSeenPassword? Icons.remove_red_eye:Icons.remove_red_eye_outlined
                        ),
                        ),
                        suffixIconColor: Color.fromARGB(255, 141, 4, 141),
                        labelText: "Password",
                        border: const OutlineInputBorder(),
                      ),
                    )
                    ,const SizedBox(
                      height: 10,
                    ),
                    Container(
                      
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: (){
                            Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => const inside()),
                            );
                          },
                          child: const Text(
                            "Log in",
                            style: TextStyle(color: Color.fromARGB(255, 141, 4, 141),
                          ),)
                          )
                        ]),
                        ),
                        const SizedBox(
                      height: 30,
                    ),
                  ]),),
                  )
                  ),
            )
          ],
        )
      ]
    ),
  );
}
}



bool isnotSeenPassword = true;
