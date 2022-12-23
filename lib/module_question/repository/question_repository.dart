import 'package:altkamul_test/consts/urls.dart';
import 'package:altkamul_test/module_question/response/question_detail_response.dart';
import 'package:altkamul_test/module_question/response/questions_response.dart';
import 'package:altkamul_test/module_network/http_client/http_client.dart';

class IdeaRepository {
  final client = ApiClient();

  Future<QuestionsResponse?> getFirstBatchQuestions() async {
    var result = await client
        .get(Urls.QUESTIONS_URL, queryParams: {'page': '1', 'pagesize': '5'});
    print('###########################');
    print(result);
    if (result == null) {
      return null;
    } else {
      return QuestionsResponse.fromJson(result);
    }
  }

  Future<QuestionsResponse?> getNextBatchQuestions({required int offset}) async {
    var result = await client.get(Urls.QUESTIONS_URL,
        queryParams: {'page': '$offset', 'pagesize': '5'});
    if (result == null) {
      return null;
    } else {
      return QuestionsResponse.fromJson(result);
    }
  }

  Future<QuestionDetailResponse?> getQuestionDetails(
      {required int questionId}) async {
    var result = await client.get(Urls.QUESTION_DETIAL_URL + '$questionId',
        queryParams: {
          'order': 'desc',
          'sort': 'activity',
          'site': 'stackoverflow'
        });
    if (result == null) {
      return null;
    } else {
      return QuestionDetailResponse.fromJson(result['items'][0]);
    }
  }
}
