
import 'dart:async';
import 'package:altkamul_test/module_offline_mode/service/sql_sevice.dart';
import 'package:altkamul_test/module_question/model/question_model.dart';
import 'package:altkamul_test/module_question/repository/question_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../response/questions_response.dart';
class QuestionsService {
  final  IdeaRepository _orderRepository = IdeaRepository();
  final OfflineService offlineService = OfflineService();
  /// Streams
  late final PublishSubject<List<QuestionModel>?> questionsPublishSubject ;
  late final PublishSubject<QuestionModel?> questionDetailPublishSubject ;


  /// Cashed Data
  late List<Data> ideaDocumentList ;

  QuestionsService(){
    questionsPublishSubject=  PublishSubject();
    questionDetailPublishSubject = PublishSubject();
    ideaDocumentList = [];

  }

  /// This method will automatically fetch first five elements from the API
  Future<void> getQuestions() async {

    var apiResponse = await _orderRepository.getFirstBatchQuestions();
    var questionsList  = <QuestionModel>[];
    if(apiResponse != null){
      ideaDocumentList = [];
      ideaDocumentList.addAll(apiResponse.data);
      ideaDocumentList.forEach((element) {
        questionsList.add(QuestionModel(id: element.question_id,
        title: element.title,
          answer_count: element.answer_count,
          creation_date:  element.creation_date,
          is_answered: element.is_answered,
          score: element.score,
          view_count: element.view_count
        ));
      });
      if(!questionsPublishSubject.isClosed){
        questionsPublishSubject.add(questionsList);
      }

      /// Add Data To Local Memory
      _addDataToLocalMemory(questionsList);

    }else {

      /// Exception
      questionsPublishSubject.add(null);
    }


  }



 /// This method to fetch the following five items
  Future<bool> fetchNextIdeas()async {
    int _offset = (ideaDocumentList.length /5).toInt() +1  ;

    var apiResponse = await _orderRepository.getNextBatchQuestions(offset:_offset );
    var questionsList  = <QuestionModel>[];
    if(apiResponse != null){
      ideaDocumentList.addAll(apiResponse.data);
      ideaDocumentList.forEach((element) {
        questionsList.add(QuestionModel(id: element.question_id,
            title: element.title,
            answer_count: element.answer_count,
            creation_date:  element.creation_date,
            is_answered: element.is_answered,
            score: element.score,
            view_count: element.view_count
        ));
      });
      if(!questionsPublishSubject.isClosed)
        questionsPublishSubject.add(questionsList);

      /// Add Data To Local Memory
      _addDataToLocalMemory(questionsList);

      return true;
    }else {
      return false;
      /// Exception
    }
  }

  /// This Private Method
  /// Add Data To Local Memory
  _addDataToLocalMemory(List<QuestionModel> questions)async{
    for(int i=0 ; i< questions.length ;i++){
      offlineService.createQuestion(questions[i]);
    }
  }
  /// This method will  fetch more details about the element
  Future<void> getQuestionDetails({required int id}) async {

  
    var apiResponse = await _orderRepository.getQuestionDetails(questionId : id);

    if(apiResponse != null){

      if(!questionDetailPublishSubject.isClosed){
        QuestionModel _q = QuestionModel(id: apiResponse.question_id,
            title: apiResponse.title,
            answer_count: apiResponse.answer_count,
            creation_date:  apiResponse.creation_date,
            is_answered: apiResponse.is_answered,
            score: apiResponse.score,
            view_count: apiResponse.view_count
        );
        _q.tags = apiResponse.tags;
        _q.link = apiResponse.link;
        questionDetailPublishSubject.add(_q);
      }


    }else {
      /// Exception
      questionDetailPublishSubject.add(null);
    }


  }

  /// This method for fetch data from local storage
  /// when there is no internet connection
  Future<void> getQuestionsFromLocalStorage() async {

    List<QuestionModel>? apiResponse = await offlineService.getItems();
    var questionsList  = <QuestionModel>[];
    if(apiResponse != null){
      ideaDocumentList.forEach((element) {
        questionsList.add(QuestionModel(id: element.question_id,
            title: element.title,
            answer_count: element.answer_count,
            creation_date:  element.creation_date,
            is_answered: element.is_answered,
            score: element.score,
            view_count: element.view_count
        ));
      });
      if(!questionsPublishSubject.isClosed)
        questionsPublishSubject.add(questionsList);

    }else {
      /// Exception
      questionsPublishSubject.add(null);
    }


  }
  closeStreams(){
    questionDetailPublishSubject.close();
  }
}

