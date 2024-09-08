import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:leetcode_widget/daily_streak/model.dart';
import 'package:leetcode_widget/main_dio.dart';
import 'package:logger/logger.dart';

class DailyStreakServices {
  static const String _leetcodeSessionKey = "LEETCODE_SESSION";
  static const String _dailyStreakQuery =
      """    query getStreakCounter {  streakCounter {    streakCount    daysSkipped    currentDayCompleted  }}""";
  static Future<DailyStreakStreakCounter> getDailyStreak(
      {String? cookie}) async {
    const aOptions = AndroidOptions(
      encryptedSharedPreferences: true,
    );
    const iOptions = IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    );
    const storage = FlutterSecureStorage(
      aOptions: aOptions,
      iOptions: iOptions,
    );

    cookie ??= await storage.read(
      key: _leetcodeSessionKey,
      aOptions: aOptions,
      iOptions: iOptions,
    );
    try {
      final response = await MainDio.dio.post(
        "/graphql",
        data: {"query": _dailyStreakQuery, "operationName": "getStreakCounter"},
        options: Options(
          headers: {
            "Cookie": cookie,
          },
        ),
      );

      return DailyStreak.fromJson(response.data).data.streakCounter;
    } catch (e, st) {
      Logger().e(e);
      Logger().e(st);
      rethrow;
    }
  }
}
