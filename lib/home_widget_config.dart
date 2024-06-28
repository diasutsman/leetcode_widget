import 'package:home_widget/home_widget.dart';
import 'package:leetcode_widget/daily_problem/services.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeWidgetConfig {
  static const String _appGroupId = 'group.dailyproblem'; // Add from here
  static const String _iOSWidgetName = 'DailyProblemWidgets';
  static const String _androidWidgetName = 'DailyProblemWidget';

  static Future<void> init() async {
    await updateDailyProblem();
    HomeWidget.setAppGroupId(_appGroupId);
    //* Check if run
    final uri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    _launchedFromWidget(uri);
    listenClicked();
  }

  static void listenClicked() {
    HomeWidget.widgetClicked.listen(_launchedFromWidget);
  }

  static void _launchedFromWidget(Uri? uri) {
    Logger().d("uri: $uri");
    Logger().d("uri.host: ${uri?.host}");
    Logger().d("uri.host: ${uri?.scheme}");
    //* Check if app is launched widget
    if (uri?.scheme.toLowerCase() == 'dailyProblemWidget'.toLowerCase()) {
      launchLeetcode();
    }
  }

  static Future<void> launchLeetcode() async {
    final problemLink =
        (await HomeWidget.getWidgetData("problem_link")).toString();
    final url = problemLink;

    if (!(await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    ))) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> updateDailyProblem() async {
    final dailyProblem = await DailyProblemServices.getDailyProblem();

    HomeWidget.saveWidgetData<String>(
        'problem_title', dailyProblem.question.title);
    HomeWidget.saveWidgetData<String>(
        'problem_difficulty', dailyProblem.question.difficulty);
    final url = "https://leetcode.com${dailyProblem.link}";
    HomeWidget.saveWidgetData<String>('problem_link', url);
    HomeWidget.saveWidgetData<String>('problem_acc_rate',
        "${dailyProblem.question.acRate.toStringAsFixed(1)}%");
    HomeWidget.updateWidget(
      iOSName: _iOSWidgetName,
      androidName: _androidWidgetName,
    );
  }
}
