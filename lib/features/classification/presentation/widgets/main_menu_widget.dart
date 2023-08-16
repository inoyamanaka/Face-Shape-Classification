import 'package:flutter/material.dart';
import '../../data/models/main_menu_att.dart';

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ModeButton extends StatelessWidget {
  const ModeButton({
    super.key,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 75,
      width: 250,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: _currentIndex == 1
            ? Color.fromARGB(255, 212, 245, 252)
            : Color.fromARGB(255, 19, 21, 34),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Text(
        MainMenuAtt.mode[_currentIndex],
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Urbanist',
          color: _currentIndex == 1
              ? Color.fromARGB(255, 19, 21, 34)
              : Color.fromARGB(255, 212, 245, 252),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
