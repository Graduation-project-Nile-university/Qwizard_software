import 'package:flutter/material.dart';
import 'package:gradproj/views/Settings/components.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      child: Column(
        children: [
          Text("Settings"),
          Container(), //will hold the user email
          TextFormField(
            controller: username,
          ),
          TextFormField(
            controller: phoneNumber,
          ),
        ],
      ),
    ));
  }
}
