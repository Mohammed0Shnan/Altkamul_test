
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryStates> {

  CategoryBloc() : super(CategoryInitState()) {

    on<CategoryEvent>((CategoryEvent event, Emitter<CategoryStates> emit) {
      if (event is CategoryLoadingEvent)
        emit(CategoryLoadingState());
      else if (event is CategoryErrorEvent){
        emit(CategoryErrorState(message: event.message));
      }
      else if (event is CategorySuccessEvent){
        emit(CategorySuccessState(data: event.data));}
    });
  }


  getCategories() async {
    this.add(CategoryLoadingEvent());
    await Future.delayed(Duration(seconds: 2));
    this.add(CategorySuccessEvent(data: ['IT','AI','Network','Graphic']));
  }
}

abstract class CategoryEvent { }
class CategoryInitEvent  extends CategoryEvent  {}

class CategorySuccessEvent  extends CategoryEvent  {
  List <String>  data;
  CategorySuccessEvent({required this.data});
}
class UpdateCategorySuccessEvent  extends CategoryEvent  {

  UpdateCategorySuccessEvent();
}

class CategoryLoadingEvent  extends CategoryEvent  {}

class CategoryErrorEvent  extends CategoryEvent  {
  String message;
  CategoryErrorEvent({required this.message});
}

abstract class CategoryStates {}

class CategoryInitState extends CategoryStates {}

class CategorySuccessState extends CategoryStates {
  List <String>  data;
  CategorySuccessState({required this.data});
}


class CategoryLoadingState extends CategoryStates {}

class CategoryErrorState extends CategoryStates {
  String message;
  CategoryErrorState({required this.message});
}

