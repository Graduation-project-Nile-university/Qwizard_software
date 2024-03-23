import 'package:flutter/material.dart';
import 'package:gradproj/views/aboutUs/meminfo.dart';

class aboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            persons.length,
            (index) => PersonCard(
              name: persons['person${index+1}']!.entries.elementAt(0).value,
              bio: persons['person${index+1}']!.entries.elementAt(1).value,
              imageloc: persons['person${index+1}']!.entries.elementAt(2).value, // Placeholder image URL
            ),
          ),
        ),
      ),
    );
  }
}

class PersonCard extends StatelessWidget {
  final String name;
  final String imageloc;
  final String bio;

  const PersonCard({
    super.key,
    required this.name,
    required this.imageloc,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
              padding: EdgeInsets.all(10)),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageloc),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                bio,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
