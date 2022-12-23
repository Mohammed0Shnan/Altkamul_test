//
import 'package:altkamul_test/abstracts/module/my_module.dart';
import 'package:altkamul_test/module_question/question_routes.dart';
import 'package:altkamul_test/module_question/ui/screens/question_detail.dart';
import 'package:flutter/material.dart';

class QuestionModule extends MyModule {

  final OrderDetailScreen _detailScreen;

  QuestionModule(
this._detailScreen

  ) ;

  Map<String, WidgetBuilder> getRoutes() {
    return {

      QuestionRoutes.QUESTION_DETAIL_SCREEN: (context) => _detailScreen,

    };
  }
}
