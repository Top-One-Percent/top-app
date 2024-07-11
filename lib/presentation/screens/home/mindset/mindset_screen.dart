import 'package:flutter/material.dart';
import 'package:top/presentation/widgets/widgets.dart';
import 'package:typewritertext/typewritertext.dart';

class MindsetScreen extends StatelessWidget {
  const MindsetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TypeWriter.text(
          '''
<h1> Greetings, Achiever! :D </h1>

<p> You've unlocked a secret area! :0 </p>

<p> Here will be the "Image" hub </p>

<p> I hope you're working hard! </p>

<p> Cool stuff coming soon! </p>

- Alejo ;)                                          
        ''',
          duration: const Duration(milliseconds: 50),
          repeat: true,
          overflow: TextOverflow.visible,
          softWrap: false,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
