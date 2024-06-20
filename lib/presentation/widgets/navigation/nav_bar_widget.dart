import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return StylishBottomBar(
      items: [
        BottomBarItem(
          icon: const Icon(Icons.home_outlined),
          title: const Text('Goals'),
          backgroundColor: Colors.white,
        ),
        BottomBarItem(
          icon: const Icon(Icons.repeat),
          title: const Text('Habits'),
          backgroundColor: Colors.white,
        ),
        BottomBarItem(
          icon: const Icon(Icons.diamond_outlined),
          title: const Text('Image'),
          backgroundColor: Colors.white,
        ),
      ],
      option: AnimatedBarOptions(
        barAnimation: BarAnimation.blink,
        iconSize: 32.0,
        iconStyle: IconStyle.animated,
      ),
      backgroundColor: Colors.black,
    );
  }
}
