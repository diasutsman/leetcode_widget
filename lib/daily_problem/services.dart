import 'package:leetcode_widget/daily_problem/model.dart';
import 'package:leetcode_widget/main_dio.dart';
import 'package:logger/logger.dart';

class DailyProblemServices {
  static const String _dailyProblemQuery =
      """    query questionOfToday {  activeDailyCodingChallengeQuestion {    date    userStatus    link    question {      acRate      difficulty      freqBar      frontendQuestionId: questionFrontendId      isFavor      paidOnly: isPaidOnly      status      title      titleSlug      hasVideoSolution      hasSolution      topicTags {        name        id        slug      }    }  }}    """;
  static Future<QuestionOfTodayDataActiveDailyCodingChallengeQuestion>
      getDailyProblem() async {
    try {
      final response = await MainDio.dio.post("/graphql", data: {
        "query": _dailyProblemQuery,
      });

      return QuestionOfToday.fromJson(response.data)
          .data
          .activeDailyCodingChallengeQuestion;
    } catch (e, st) {
      Logger().e(e);
      Logger().e(st);
      rethrow;
    }
  }
}
