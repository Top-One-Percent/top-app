import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';

class MindsetScreen extends StatelessWidget {
  const MindsetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TypeWriter.text(
          '''
Greetings, Achiever!

You've unlocked a secret area

Here will be the "Image" hub

I hope you're working hard!

Cool stuff coming soon!

- Alejo P                                                 
        ''',
          duration: const Duration(milliseconds: 50),
          repeat: true,
          overflow: TextOverflow.visible,
          softWrap: false,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
