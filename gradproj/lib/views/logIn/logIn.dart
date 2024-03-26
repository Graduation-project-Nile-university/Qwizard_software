import 'package:flutter/material.dart';
import 'package:gradproj/views/inside/inside.dart';
import 'package:gradproj/views/home/HomeView.dart';

class logIn extends StatefulWidget {
  const logIn({Key? key});

  @override
  State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 255, 191, 0),
                    Color.fromARGB(255, 141, 4, 141),
                  ],
                  tileMode: TileMode.repeated,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 30),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email address must not be empty";
                              }
                              if (!value.contains("@")) {
                                return "Email address is not valid";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              prefixIconColor: Color.fromARGB(255, 141, 4, 141),
                              labelText: "Email Address",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password must not be empty";
                              }
                              if (!value.contains("@") && !value.contains("_")) {
                                return "password must contain a special character";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              prefixIconColor: Color.fromARGB(255, 141, 4, 141),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isnotSeenPassword = !isnotSeenPassword;
                                  });
                                },
                                icon: Icon(isnotSeenPassword ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
                              ),
                              suffixIconColor: Color.fromARGB(255, 141, 4, 141),
                              labelText: "Password",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const inside()),
                                    );
                                  },
                                  child: Text(
                                    "Log in",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 141, 4, 141),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

bool isnotSeenPassword = true;
