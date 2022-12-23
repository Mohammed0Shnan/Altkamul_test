
import 'package:altkamul_test/module_question/model/question_model.dart';
import 'package:altkamul_test/module_question/service/question.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionDetailBloc extends Bloc<QuestionDetailEvent,QuestionDetailStates> {
  final QuestionsService _service = QuestionsService();
  QuestionDetailBloc() : super(QuestionDetailLoadingState()) {

    on< QuestionDetailEvent>((  QuestionDetailEvent event, Emitter<QuestionDetailStates> emit) {
      if (event is   QuestionDetailLoadingEvent)
        emit(QuestionDetailLoadingState());
      else if (event is   QuestionDetailErrorEvent){
        emit(QuestionDetailErrorState(message: event.message));
      }
      else if (event is   QuestionDetailSuccessEvent){
        emit(QuestionDetailSuccessState(data: event.data));}
    });


  }



  void getQDetail({required int qId}) {
    this.add(QuestionDetailLoadingEvent());
    _service.questionDetailPublishSubject.listen((value) {

      if(value != null){
        this.add(QuestionDetailSuccessEvent(data:value));

      }else
      {
        this.add(QuestionDetailErrorEvent(message: 'Error in get Question detail !!'));
      }
    });
  _service.getQuestionDetails(id: qId);
  }



}



abstract class QuestionDetailEvent { }

class QuestionDetailSuccessEvent  extends QuestionDetailEvent  {
  QuestionModel  data;
  QuestionDetailSuccessEvent({required this.data});
}

class   QuestionDetailLoadingEvent  extends  QuestionDetailEvent  {}

class   QuestionDetailErrorEvent  extends   QuestionDetailEvent  {
  String message;
  QuestionDetailErrorEvent({required this.message});
}

abstract class   QuestionDetailStates {}


class   QuestionDetailSuccessState extends  QuestionDetailStates {
  QuestionModel data;
  QuestionDetailSuccessState({required this.data});
}


class   QuestionDetailLoadingState extends   QuestionDetailStates {}

class   QuestionDetailErrorState extends   QuestionDetailStates {
  String message;
  QuestionDetailErrorState({required this.message});
}