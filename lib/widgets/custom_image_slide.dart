import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class ImageSlide extends StatefulWidget {
  @override
  State<ImageSlide> createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  int _currentIndex = 0;

  final List<String> imageList = [
    'Assets/images/image1.jpg',
    'Assets/images/image2.jpg',
    'Assets/images/image3.jpg',
    'Assets/images/image4.jpg',
    'Assets/images/image5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 300,
        width: 330,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: CarouselSlider(
          items: imageList.map((image) {
            return Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    // Jika gambar gagal dimuat karena kesalahan, tampilkan efek shimmer sebagai gantinya
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                      ),
                    );
                  },
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 250,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageList.asMap().entries.map((entry) {
          int index = entry.key;
          String image = entry.value;
          return Container(
            width: 10,
            height: 10,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentIndex == index ? Colors.black : Colors.grey,
            ),
          );
        }).toList(),
      )
    ]);
  }
}
