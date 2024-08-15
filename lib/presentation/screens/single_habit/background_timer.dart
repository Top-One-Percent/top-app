import 'package:shared_preferences/shared_preferences.dart';

class BackgroundTimer {
  static const String _startTimeKey = 'start_time';
  static const String _elapsedSecondsKey = 'elapsed_seconds';
  static const String _isRunningKey = 'is_running';

  static Future<void> startTimer(int elapsedSeconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_startTimeKey, DateTime.now().millisecondsSinceEpoch);
    await prefs.setInt(_elapsedSecondsKey, elapsedSeconds);
    await prefs.setBool(_isRunningKey, true);
  }

  static Future<void> stopTimer() async {
    final prefs = await SharedPreferences.getInstance();
    final int? startTime = prefs.getInt(_startTimeKey);
    final int? elapsedSeconds = prefs.getInt(_elapsedSecondsKey);

    if (startTime != null && elapsedSeconds != null) {
      final int currentTime = DateTime.now().millisecondsSinceEpoch;
      final int additionalSeconds = ((currentTime - startTime) / 1000).floor();
      await prefs.setInt(
          _elapsedSecondsKey, elapsedSeconds + additionalSeconds);
      await prefs.setBool(_isRunningKey, false);
    }
  }

  static Future<void> resetTimer() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_startTimeKey, 0);
    await prefs.setInt(_elapsedSecondsKey, 0);
    await prefs.setBool(_isRunningKey, false);
  }

  static Future<int> getElapsedSeconds() async {
    final prefs = await SharedPreferences.getInstance();
    final int? startTime = prefs.getInt(_startTimeKey);
    final int? elapsedSeconds = prefs.getInt(_elapsedSecondsKey);
    final bool? isRunning = prefs.getBool(_isRunningKey);

    if (startTime != null && elapsedSeconds != null && isRunning != null) {
      if (isRunning) {
        final int currentTime = DateTime.now().millisecondsSinceEpoch;
        final int additionalSeconds =
            ((currentTime - startTime) / 1000).floor();
        return elapsedSeconds + additionalSeconds;
      } else {
        return elapsedSeconds;
      }
    } else {
      return 0;
    }
  }

  static Future<bool> isRunning() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isRunningKey) ?? false;
  }
}
