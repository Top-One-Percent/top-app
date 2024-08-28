import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/presentation/providers/providers.dart';
import 'package:top/presentation/widgets/widgets.dart';

import '../../../../domain/models/tip.dart';

class MentorChatScreen extends StatelessWidget {
  final String tipId;

  const MentorChatScreen({super.key, required this.tipId});

  @override
  Widget build(BuildContext context) {
    final Tip tip = Provider.of<TipProvider>(context)
        .tips
        .firstWhere((tip) => tip.id == tipId);

    final List<String> msjs = tip.messages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('T.O.P Mentor',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Image.asset('assets/top-mentor.png'),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30.0),
          Expanded(
            child: ListView.builder(
              itemCount: msjs.length,
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              itemBuilder: (context, index) {
                return MsjBubbleWidget(
                  msj: msjs[index],
                  total: msjs.length + 1,
                  current: index + 1,
                );
              },
            ),
          ),
          SafeArea(
            
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: WhiteFilledButtonWidget(
                onPressed: () {
                  appRouter.pop();
                },
                buttonText: 'Ok',
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
