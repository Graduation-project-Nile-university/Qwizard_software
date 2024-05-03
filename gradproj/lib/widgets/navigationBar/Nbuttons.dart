import 'package:flutter/material.dart';

class Nbuttons extends StatelessWidget {

  final String text;
  final Widget route;

  const Nbuttons({super.key, required this.text, required this.route});
  
  @override
  Widget build(BuildContext context) {
    return 
      TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => route));
                },
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              );
}
}