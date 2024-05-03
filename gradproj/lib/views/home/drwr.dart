import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';


class Drwr extends StatelessWidget {
  const Drwr({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 141, 4, 141),
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
            title: Row(
              children: [
                Icon(Icons.home),
                const Text('  Home'),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, "/home");
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.subscriptions),
                const Text('  Subscriptions'),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, "/subscriptions");
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.people),
                const Text('  About Us'),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, "/aboutus");
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.settings),
                const Text('  Settings'),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, "/settings");
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.generating_tokens),
                const Text('  Test'),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, "/Test");
            },
          ),
          BlocBuilder<QuizardCubit, States>(builder: (context, state) {
            return ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  Text(
                    '  Sign Out',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              onTap: () async {
                await AuthenticationCubit.GET(context)
                    .signOut()
                    .then((value) => Navigator.pushNamedAndRemoveUntil(
                        context, "/login", (route) => false))
                    .catchError((onError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("${onError}"),
                    backgroundColor: Colors.red,
                  ));
                });
              },
            );
          })
        ],
      ),
    );
  }
}
