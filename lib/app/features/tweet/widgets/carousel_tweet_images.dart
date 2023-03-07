import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselTweetImage extends StatefulWidget {

  final List<String> imageLinks;
  const CarouselTweetImage({super.key, required this.imageLinks});

  @override
  State<CarouselTweetImage> createState() => _CarouselTweetImageState();
}

class _CarouselTweetImageState extends State<CarouselTweetImage> {

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: CarouselSlider(
            items: widget.imageLinks.map((link) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.network(
                    link, 
                    fit: BoxFit.contain,
                  ),
                );
              } ,
            ).toList(), 
            options: CarouselOptions(
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              }
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imageLinks.asMap().entries.map(
            (index) {
              return Container(
                height: 12,
                width: 12,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(_currentIndex == index.key ? 0.9 : 0.4),
                ),
              );
            },
          ).toList(),
        )
      ],
    );
  }
}