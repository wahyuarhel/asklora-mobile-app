import 'question.dart';

enum QuestionSection {
  privacy('privacy'),
  openness('openness'),
  conscientiousness('conscientiousness'),
  neuroticism('neuroticism'),
  investmentStyle('investment_style'),
  omniSearch('omnisearch'),
  extrovert('extrovert');

  final String value;

  const QuestionSection(this.value);
}

enum QuestionType {
  choices('choices'),
  slider('slider'),
  descriptive('descriptive'),
  omniSearch('omnisearch');

  /// In case we want to add any extra screens in the PPI section.
  // unique('unique');

  final String value;

  const QuestionType(this.value);
}

class Fixture {
  static final Fixture _singleton = Fixture._internal();

  factory Fixture() => _singleton;

  Fixture._internal();

  static Fixture get instance => _singleton;

  static List<Question> privacyQuestions = [];
  static List<Question> personalisedQuestion = [];
  static List<Question> investmentStyleQuestion = [];

  List<Question> get getPrivacyQuestions {
    return privacyQuestions;
  }

  set setPrivacyQuestions(Question question) {
    privacyQuestions.add(question);
  }

  List<Question> get getPersonalisedQuestion {
    return personalisedQuestion;
  }

  set setPersonalisedQuestion(Question question) {
    personalisedQuestion.add(question);
  }

  List<Question> get getInvestmentStyleQuestion {
    return investmentStyleQuestion;
  }

  set setInvestmentStyleQuestion(Question question) {
    investmentStyleQuestion.add(question);
  }

  void clearQuestion() {
    investmentStyleQuestion.clear();
    personalisedQuestion.clear();
    privacyQuestions.clear();
  }

  Fixture fixPersonalisedQuestion(List<Question> questionCollection) {
    personalisedQuestion.clear();
    privacyQuestions.clear();
    for (var element in questionCollection) {
      if (element.section == QuestionSection.privacy.value) {
        setPrivacyQuestions = element;
      }
      if (element.section == QuestionSection.openness.value ||
          element.section == QuestionSection.conscientiousness.value ||
          element.section == QuestionSection.neuroticism.value ||
          element.section == QuestionSection.extrovert.value) {
        setPersonalisedQuestion = element;
      }
      if (element.section == QuestionSection.investmentStyle.value) {
        setInvestmentStyleQuestion = element;
      }
      if (element.section == QuestionSection.omniSearch.value) {
        element
          ..questionType = QuestionType.omniSearch.value
          ..section = QuestionSection.investmentStyle.value;
        setInvestmentStyleQuestion = element;
      }
    }
    return this;
  }

  Fixture fixInvestmentStyleQuestion(List<Question> questionCollection) {
    investmentStyleQuestion.clear();
    for (var element in questionCollection) {
      if (element.section == QuestionSection.privacy.value) {
        setPrivacyQuestions = element;
      }
      if (element.section == QuestionSection.openness.value ||
          element.section == QuestionSection.conscientiousness.value ||
          element.section == QuestionSection.neuroticism.value ||
          element.section == QuestionSection.extrovert.value) {
        setPersonalisedQuestion = element;
      }
      if (element.section == QuestionSection.investmentStyle.value) {
        setInvestmentStyleQuestion = element;
      }
      if (element.section == QuestionSection.omniSearch.value) {
        element
          ..questionType = QuestionType.omniSearch.value
          ..section = QuestionSection.investmentStyle.value;
        setInvestmentStyleQuestion = element;
      }
    }
    return this;
  }

  int indexOfPrivacyQuestionsByUid(String uid) =>
      privacyQuestions.indexWhere((question) => question.questionId == uid);

  int indexOfPersonalisedQuestionsByUid(String uid) =>
      personalisedQuestion.indexWhere((question) => question.questionId == uid);

  int indexOfInvestmentStyleQuestionByUid(String uid) => investmentStyleQuestion
      .indexWhere((question) => question.questionId == uid);
}
