import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/views/logIn/forgetPasswordScreens/components.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context)!.settings.arguments);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Change Password",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: newPassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          prefixIconColor: Color.fromARGB(255, 141, 4, 141),
                          labelText: "New Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: confirmNewPassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          prefixIconColor: Color.fromARGB(255, 141, 4, 141),
                          labelText: "Confirm New Password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (confirmedPassword) {
                          if (confirmedPassword != newPassword.text) {
                            return "Passwords are not equal";
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<QuizardCubit, States>(builder: (context, state) {
            return ElevatedButton(
                onPressed: () {
                  FormState _formState = formKey.currentState!;
                  if (_formState.validate()) {
                    AuthenticationCubit.GET(context)
                        .changePasssword(
                            ModalRoute.of(context)!.settings.arguments
                                as String,
                            newPassword.text)
                        .then((value) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/login", (route) => false);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("${value.data["success"]}"),
                        backgroundColor: Colors.green,
                      ));
                    }).catchError((onError) => print(onError.response.data));
                  }
                },
                child: Text("Change Password"));
          })
        ],
      ),
    );
  }
}
