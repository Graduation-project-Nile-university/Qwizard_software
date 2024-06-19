import 'package:flutter/material.dart';
import 'package:gradproj/views/aboutUs/meminfo.dart';

import 'package:flutter/material.dart';

class aboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            padding: EdgeInsets.all(10.0),
            itemCount: persons.length,
            itemBuilder: (context, index) {
              return PersonCard(
                name: persons['person${index + 1}']!.entries.elementAt(0).value,
                bio: persons['person${index + 1}']!.entries.elementAt(1).value,
                imageloc:
                    persons['person${index + 1}']!.entries.elementAt(2).value,
              );
            },
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
    Key? key,
    required this.name,
    required this.imageloc,
    required this.bio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width > 600
        ? MediaQuery.of(context).size.width / 5
        : MediaQuery.of(context).size.width / 2;

    return Card(
      margin: EdgeInsets.all(5),
      child: SingleChildScrollView(
        // Wrapping with SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              width: cardWidth * 0.6,
              height: cardWidth * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(imageloc),
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
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                bio,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 10), // Adding some extra space at the bottom
          ],
        ),
      ),
    );
  }
}
