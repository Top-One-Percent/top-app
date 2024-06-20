import 'dart:async';

import 'package:flutter/material.dart';

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
    final seconds = targetDate.difference(DateTime.now()).inSeconds;
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
      ],
    );
  }
}
