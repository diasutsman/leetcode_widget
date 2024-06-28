import 'package:ansicolor/ansicolor.dart';
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class MainDio {
  static Dio? _dio;

  static Dio get dio {
    if (_dio != null) return _dio as Dio;

    _dio = Dio(
      BaseOptions(
        baseUrl: "https://leetcode.com",
        connectTimeout: const Duration(minutes: 1),
        followRedirects: false,
      ),
    );

    _dio?.interceptors.addAll([
      TalkerDioLogger(
        settings: TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
          // Blue http requests logs in console
          requestPen: AnsiPen()..blue(),
          // Green http responses logs in console
          responsePen: AnsiPen()..green(),
          // Error http logs in console
          errorPen: AnsiPen()..red(),
        ),
      ),
    ]);

    return _dio as Dio;
  }
}
