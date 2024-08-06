import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> initializeService(int initialElapsedSeconds) async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId:
          'my_foreground', // must match with notification channel id
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  await service.startService();
  service.invoke('initTimer', {'elapsedSeconds': initialElapsedSeconds});
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  int elapsedSeconds = 0;
  bool isRunning = false;

  service.on('initTimer').listen((event) {
    elapsedSeconds = event!['elapsedSeconds'];
  });

  service.on('startTimer').listen((event) {
    isRunning = true;
  });

  service.on('stopTimer').listen((event) {
    isRunning = false;
  });

  service.on('resetTimer').listen((event) {
    elapsedSeconds = 0;
    service.invoke('updateTimer', {"elapsedSeconds": elapsedSeconds});
  });

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (isRunning) {
      elapsedSeconds++;
      service.invoke('updateTimer',
          {"elapsedSeconds": elapsedSeconds, 'isRunning': isRunning});
    }

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin.show(
          888,
          'T.O.P',
          'Timer is running: ${_formatTime(elapsedSeconds)}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: '@mipmap/ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
      }
    }
  });
}

String _formatTime(int seconds) {
  final hours = seconds ~/ 3600;
  final minutes = (seconds % 3600) ~/ 60;
  final remainingSeconds = seconds % 60;
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}
