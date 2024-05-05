import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


final List<String> imgList = [
  'assets/logo.PNG',
  'assets/omar.jpeg',
  'assets/ahmed.jpeg',
  'assets/ahmad.jpeg',
  'assets/saif.jpeg',
  'assets/zeena.jpeg',
  'assets/mohamed.jpeg',
];

final List<Widget> imageSliders = imgList
    .map((item) =>  Container(
            margin: const EdgeInsets.all(6.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child: Stack(
                  children: [
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    
                  ],
                )),
          ),
        )
    .toList();

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2,milliseconds: 50),
                enlargeCenterPage: true,
                //aspectRatio: 2,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.3)),
              ),
            );
          }).toList(),
        ),
      ]
    
    );
}
}