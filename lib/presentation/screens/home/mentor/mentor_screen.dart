import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/config/theme/app_colors.dart';
import 'package:top/domain/models/models.dart';
import 'package:top/presentation/providers/providers.dart';
import 'package:top/presentation/widgets/cards/icon_text_card.dart';

class MentorScreen extends StatefulWidget {
  const MentorScreen({super.key});

  @override
  State<MentorScreen> createState() => _MentorScreenState();
}

class _MentorScreenState extends State<MentorScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<TipProvider>(context, listen: false).loadTips();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TipProvider>(
        builder: (context, tipProvider, child) {
          if (tipProvider.tips.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: AppColors.bluishWhite,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
                                  SizedBox(height: 10.0),
                                  Text(
                                    'I will help you make the most of your journey with the T.O.P app.',
                                    style: TextStyle(color: Colors.black, fontSize: 16.0),
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
                    _buildTipsList('Recomended 🚀', tipProvider.favoriteTips),
                    const SizedBox(height: 20.0),
                    _buildTipsList('All Tips💡', tipProvider.normalTips),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildTipsList(String title, List<Tip> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 22.0,
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
            icon: items[index].isGeneral ? Icons.help_outlined : Icons.settings,
            text: items[index].name,
            onTap: () {
              appRouter.push('/mentorChat/${items[index].id}');
            },
          );
        },
      ),
    ],
  );
}
