import 'package:flutter/material.dart';

class ParallaxImage extends StatefulWidget {
  final String imageUrl;
  final double parallaxFactor;

  const ParallaxImage({
    Key? key,
    required this.imageUrl,
    this.parallaxFactor = 0.5,
  }) : super(key: key);

  @override
  _ParallaxImageState createState() => _ParallaxImageState();
}

class _ParallaxImageState extends State<ParallaxImage> {
  double offset = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth +
            2 * (constraints.maxWidth * widget.parallaxFactor);
        double height = constraints.maxHeight;
        return Stack(
          children: [
            Positioned(
              left: -(offset.abs() * widget.parallaxFactor),
              child: Image.network(
                widget.imageUrl,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: -(offset.abs() * widget.parallaxFactor),
              child: Image.network(
                widget.imageUrl,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            NotificationListener<ScrollUpdateNotification>(
              onNotification: (notification) {
                setState(() {
                  offset += notification.scrollDelta!;
                });
                return true;
              },
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Colors.transparent,
              ),
            ),
          ],
        );
      },
    );
  }
}
