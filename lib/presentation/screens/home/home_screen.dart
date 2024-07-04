import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:top/presentation/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          GoalsScreen(),
          HabitsScreen(),
          DailyOnePercentScreen(),
          MindsetScreen(),
        ],
      ),
      bottomNavigationBar: StylishBottomBar(
        items: [
          BottomBarItem(
            icon: const Icon(Icons.access_time),
            title: const Text('Goals'),
            backgroundColor: Colors.white,
          ),
          BottomBarItem(
            icon: const Icon(Icons.repeat),
            title: const Text('Habits'),
            backgroundColor: Colors.white,
          ),
          BottomBarItem(
            icon: const Icon(Icons.plus_one_sharp),
            title: const Text('Daily'),
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
        currentIndex: selected,
        onTap: (index) {
          pageController.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
    );
  }
}
