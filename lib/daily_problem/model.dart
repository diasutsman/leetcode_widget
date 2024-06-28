class QuestionOfToday {
  QuestionOfTodayData data;

  QuestionOfToday({
    required this.data,
  });

  factory QuestionOfToday.fromJson(Map<String, dynamic> json) =>
      QuestionOfToday(
        data: QuestionOfTodayData.fromJson(json['data']),
      );
}

class QuestionOfTodayData {
  QuestionOfTodayDataActiveDailyCodingChallengeQuestion
      activeDailyCodingChallengeQuestion;

  QuestionOfTodayData({
    required this.activeDailyCodingChallengeQuestion,
  });

  factory QuestionOfTodayData.fromJson(Map<String, dynamic> json) =>
      QuestionOfTodayData(
        activeDailyCodingChallengeQuestion:
            QuestionOfTodayDataActiveDailyCodingChallengeQuestion.fromJson(
          json['activeDailyCodingChallengeQuestion'],
        ),
      );
}

class QuestionOfTodayDataActiveDailyCodingChallengeQuestion {
  DateTime date;
  String userStatus;
  String link;
  DailyCodingChallangeQuestion question;

  QuestionOfTodayDataActiveDailyCodingChallengeQuestion({
    required this.date,
    required this.userStatus,
    required this.link,
    required this.question,
  });

  factory QuestionOfTodayDataActiveDailyCodingChallengeQuestion.fromJson(
          Map<String, dynamic> json) =>
      QuestionOfTodayDataActiveDailyCodingChallengeQuestion(
        date: DateTime.parse(json['date']),
        userStatus: json['userStatus'],
        link: json['link'],
        question: DailyCodingChallangeQuestion.fromJson(json['question']),
      );
}

class DailyCodingChallangeQuestion {
  double acRate;
  String difficulty;
  String? freqBar;
  String frontendQuestionId;
  bool isFavor;
  bool paidOnly;
  String? status;
  String title;
  String titleSlug;
  bool hasVideoSolution;
  bool hasSolution;

  List<TopicTag> topicTags;

  DailyCodingChallangeQuestion({
    required this.acRate,
    required this.difficulty,
    required this.freqBar,
    required this.frontendQuestionId,
    required this.isFavor,
    required this.paidOnly,
    required this.status,
    required this.title,
    required this.titleSlug,
    required this.hasVideoSolution,
    required this.hasSolution,
    required this.topicTags,
  });

  factory DailyCodingChallangeQuestion.fromJson(Map<String, dynamic> json) =>
      DailyCodingChallangeQuestion(
        acRate: json['acRate'],
        difficulty: json['difficulty'],
        freqBar: json['freqBar'],
        frontendQuestionId: json['frontendQuestionId'],
        isFavor: json['isFavor'],
        paidOnly: json['paidOnly'],
        status: json['status'],
        title: json['title'],
        titleSlug: json['titleSlug'],
        hasVideoSolution: json['hasVideoSolution'],
        hasSolution: json['hasSolution'],
        topicTags: List<TopicTag>.from(
            json['topicTags'].map((x) => TopicTag.fromJson(x))),
      );
}

class TopicTag {
  String name;
  String id;
  String slug;

  TopicTag({
    required this.name,
    required this.id,
    required this.slug,
  });

  factory TopicTag.fromJson(Map<String, dynamic> json) => TopicTag(
        name: json['name'],
        id: json['id'],
        slug: json['slug'],
      );
}
