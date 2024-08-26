import 'package:flutter/material.dart';
import 'package:top/config/theme/app_colors.dart';
import 'package:top/presentation/widgets/cards/icon_text_card.dart';

class MentorScreen extends StatelessWidget {
  const MentorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: AppColors.bluishWhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi! I\'m T.O.P Mentor',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'I\'ll help you make the most of your journey with the T.O.P app.\nLet\'s achieve greatness together!',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Image.asset('assets/top-mentor.png'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                const Text(
                  'Recomended 🚀',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return IconTextCard(
                        icon:
                            index.isEven ? Icons.settings : Icons.help_outline,
                        text: 'How to set a good goal');
                  },
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'General Tips 💡',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return IconTextCard(
                        icon:
                            index.isEven ? Icons.settings : Icons.help_outline,
                        text: 'How to set a good goal');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTipsList(String title, List<dynamic> items) {
  //TODO: CHANGE TO TYPE 'TIP'
  return Column(
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 20.0),
      ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return IconTextCard(
            icon: items[index].icon,
            text: items[index].name,
          );
        },
      ),
    ],
  );
}
