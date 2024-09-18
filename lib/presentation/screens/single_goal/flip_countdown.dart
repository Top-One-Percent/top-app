import 'dart:async';

import 'package:flutter/material.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/config/theme/app_colors.dart';
import 'package:top/presentation/widgets/widgets.dart';

class FlipCountdown extends StatefulWidget {
  final DateTime targetDate;

  const FlipCountdown({super.key, required this.targetDate});

  @override
  State<FlipCountdown> createState() => _FlipCountdownState();
}

class _FlipCountdownState extends State<FlipCountdown> {
  late Timer timer;
  Duration duration = const Duration();

  void _calculateTimeLeft(DateTime targetDate) {
    int seconds = targetDate.difference(DateTime.now()).inSeconds;
    if (seconds < 0) seconds = 0;
    setState(() => duration = Duration(seconds: seconds));
  }

  @override
  void initState() {
    _calculateTimeLeft(widget.targetDate);

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _calculateTimeLeft(widget.targetDate),
    );

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 32.0);
    var labelStyle = Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18.0);

    final days = DefaultTextStyle(
      style: textStyle,
      child: Text(
        duration.inDays > 99
            ? duration.inDays.toString().padLeft(3, '0')
            : duration.inDays.toString().padLeft(2, '0'),
      ),
    );

    final hours = DefaultTextStyle(
      style: textStyle,
      child: Text(
        duration.inHours.remainder(24).toString().padLeft(2, '0'),
      ),
    );

    final minutes = DefaultTextStyle(
      style: textStyle,
      child: Text(
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
      ),
    );

    final seconds = DefaultTextStyle(
      style: textStyle,
      child: Text(
        duration.inSeconds.remainder(60).toString().padLeft(2, '0'),
      ),
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: days,
                ),
                DefaultTextStyle(style: labelStyle, child: const Text('Days'))
              ],
            ),
            const SizedBox(width: 25.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: hours,
                ),
                DefaultTextStyle(style: labelStyle, child: const Text('Hours'))
              ],
            ),
            const SizedBox(width: 25.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: minutes,
                ),
                DefaultTextStyle(style: labelStyle, child: const Text('Minutes'))
              ],
            ),
            const SizedBox(width: 25.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: seconds,
                ),
                DefaultTextStyle(style: labelStyle, child: const Text('Seconds'))
              ],
            ),
          ],
        ),
        const SizedBox(height: 15.0),
        duration == const Duration(seconds: 0)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Time is up', style: TextStyle(fontSize: 20.0)),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: AppColors.darkGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'If you have achieved your goal you can leave it as is, it will be moved to the "Achieved Goals" section. \n\nIf you have not reached it, edit the deadline to give yourself more time.',
                                  style: TextStyle(fontSize: 18.0),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 15.0),
                                WhiteFilledButtonWidget(
                                  onPressed: () {
                                    appRouter.pop();
                                  },
                                  buttonText: 'Ok',
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.help_outline, color: Colors.white),
                  )
                ],
              )
            : const SizedBox()
      ],
    );
  }
}
