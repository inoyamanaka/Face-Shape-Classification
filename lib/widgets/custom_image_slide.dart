import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class ImageSlide extends StatefulWidget {
  final List<String> imageList;
  ImageSlide({required this.imageList});

  @override
  State<ImageSlide> createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.imageList);
    return Column(children: [
      SizedBox(
        height: 10,
      ),
      widget.imageList == null
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.grey[300],
              ),
            )
          : Container(
              height: 300,
              width: 330,
              decoration: BoxDecoration(
                // color: Colors.amber,
                borderRadius: BorderRadius.circular(25),
              ),
              child: CarouselSlider(
                items: widget.imageList.map((image) {
                  return Container(
                    height: 300,
                    width: 330,
                    child: Stack(children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          width: 330,
                          height: 300,
                          errorBuilder: (context, error, stackTrace) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                            );
                          },
                        ),
                      ),
                    ]),
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
        children: widget.imageList.asMap().entries.map((entry) {
          int index = entry.key;
          // String image = entry.value;
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: _currentIndex == index ? 25 : 10,
            height: 10,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              shape: BoxShape.rectangle,
              color: _currentIndex == index ? Colors.black : Colors.grey,
            ),
          );
        }).toList(),
      )
    ]);
  }
}
