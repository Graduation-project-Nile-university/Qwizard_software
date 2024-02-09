import 'package:flutter/material.dart';

class centeredView extends StatelessWidget {
  final Widget? child;
  const centeredView({Key? key, this.child}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(constraints: BoxConstraints(maxWidth: 1200,),
      child: child,
      ),
    );
  }
}