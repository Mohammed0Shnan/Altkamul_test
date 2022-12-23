
import 'dart:async';
import 'package:altkamul_test/module_question/model/question_model.dart';
import 'package:altkamul_test/module_question/service/question.service.dart';
import 'package:altkamul_test/module_question/state_manager/batch_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsBloc extends Bloc<QuestionsEvent,QuestionsStates>{
  final QuestionsService _service = QuestionsService();
  final BatchBloc _batchBloc = BatchBloc();

  get batchBloc => _batchBloc;
  QuestionsBloc() : super(QuestionsLoadingState()) {

    on<QuestionsEvent>((QuestionsEvent event, Emitter<QuestionsStates> emit) {
      if (event is QuestionsLoadingEvent)
        {
          emit(QuestionsLoadingState());

        }
      else if (event is QuestionsErrorEvent){
        emit(QuestionsErrorState(message: event.message));
      }

      else if (event is QuestionsSuccessEvent){
        emit(QuestionsSuccessState(ideas: event.ideas,message: null));
      }


    });
    getQuestions();
  }



  void getQuestions() {

     this.add(QuestionsLoadingEvent());
     _service.questionsPublishSubject.listen((value) {

       if(value != null){
         this.add(QuestionsSuccessEvent(ideas: value));

       }else
       {
         this.add(QuestionsErrorEvent(message: 'Error In Fetch Data !!'));
       }
     });
     _service.getQuestions();
  }

  /// This method for fetch data from local storage
  getQuestionsFromLocalStorage(){
    this.add(QuestionsLoadingEvent());
    _service.questionsPublishSubject.listen((value) {

      if(value != null){
        this.add(QuestionsSuccessEvent(ideas: value));

      }else
      {
        this.add(QuestionsErrorEvent(message: 'Error In Fetch Data !!'));
      }
    });
    _service.getQuestionsFromLocalStorage();
  }

  /// Page Init
 void fetchNextIdeas()  {
   _batchBloc.emitLoadingState();
   _service.fetchNextIdeas().then((value) {
      if(value){
        _batchBloc.emitInitState();
      }else{
        _batchBloc.emitErrorState();
      }
    });
  }


  @override
  Future<void> close() {
    print('close pending stream from bloc layer++++++++++++++++++++++');
    _batchBloc.close();
    _service.closeStreams();
    return super.close();
  }
}


abstract class QuestionsEvent { }
class QuestionsInitEvent  extends QuestionsEvent  {}

class QuestionsSuccessEvent  extends QuestionsEvent  {
  List<QuestionModel>  ideas;
  QuestionsSuccessEvent({required this.ideas});
}
class QuestionsLoadingEvent  extends QuestionsEvent  {}

class QuestionsErrorEvent  extends QuestionsEvent  {
  String message;
  QuestionsErrorEvent({required this.message});
}

class CaptainOrderDeletedErrorEvent  extends QuestionsEvent  {
  String message;
  CaptainOrderDeletedErrorEvent({required this.message});
}




abstract class QuestionsStates {}

class QuestionsInitState extends QuestionsStates {}

class QuestionsSuccessState extends QuestionsStates {
  List<QuestionModel>  ideas;

  String? message;
  QuestionsSuccessState({required this.ideas,required this.message});
}
class QuestionsLoadingState extends QuestionsStates {}

class QuestionsErrorState extends QuestionsStates {
  String message;
  QuestionsErrorState({required this.message});
}






