import 'dart:io';
import 'package:altkamul_test/module_offline_mode/bloc/connection_bloc.dart';
import 'package:altkamul_test/module_question/model/question_model.dart';
import 'package:altkamul_test/module_question/question_routes.dart';
import 'package:altkamul_test/module_question/state_manager/batch_bloc.dart';
import 'package:altkamul_test/module_question/state_manager/questions_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class QuestionsScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late final QuestionsBloc _bloc ;
  late final ScrollController _ideaScrollController ;

  @override
  void initState() {
    _bloc = QuestionsBloc();
    _bloc.getQuestions();
    _ideaScrollController = ScrollController();
    _ideaScrollController.addListener(_ideaScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    _ideaScrollController.dispose();
    super.dispose();
  }

  void _ideaScrollListener() {
    if (_ideaScrollController.offset == _ideaScrollController.position.maxScrollExtent &&
        !_ideaScrollController.position.outOfRange) {
      _bloc.fetchNextIdeas();
    }
  }
  @override
  Widget build(BuildContext context) {
    var connectivityBloc = context.read<InternetService>();
    return  Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title:   Text('Questions',style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 8,),
            BlocConsumer<InternetService,InternetState>(

              bloc: connectivityBloc,
              listener: (context,state){
                if(state is InternetDisConnected){
                  _bloc.getQuestionsFromLocalStorage();
                }
              },

              builder: (context,state){
                if(state is InternetDisConnected){
                  return Center(child: Text('Internet DisConnected' ,style: TextStyle(color: Colors.red , fontSize: 17.0,fontWeight: FontWeight.w500),),);
                }else{
                  return SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: 8,),

            Expanded(
                child: getQuestions()
            ),
          ],
        ),
      ),


    );


  }
  Future<void> onRefreshIdeas()async {
    _bloc.getQuestions();
  }
  Widget getQuestions(){
    return BlocConsumer<QuestionsBloc ,QuestionsStates >(
        bloc: _bloc,
        listener: (context ,state){
        },
        builder: (maincontext,state) {

          if(state is QuestionsErrorState)
            return Center(
              child: GestureDetector(
                onTap: (){

                },
                child: Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(),
                  child: Text(state.message,style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
                ),
              ),
            );

          else if(state is QuestionsSuccessState) {
            List<QuestionModel> questions = state.ideas;

            if(questions.isEmpty)
              return Center(
                  child:   Text('Empty')
              );
            else
              return RefreshIndicator(
                onRefresh: ()=>onRefreshIdeas(),
                child: Scrollbar(
                  child: ListView.separated(
                    itemCount:questions.length +1,
                    controller: _ideaScrollController,
                    separatorBuilder: (context,index){
                      return SizedBox(height: 8,);
                    },
                    itemBuilder: (context,index){
                      if(index == questions.length){
                        return BlocBuilder<BatchBloc,BatchStates>(
                          bloc: _bloc.batchBloc,
                          builder: (BuildContext context, state) {

                            if(state is BatchLoadingState){
                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.symmetric(vertical: 32.0),
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: SizedBox(
                                  height: 20,width: 20,
                                  child: Platform.isIOS? CupertinoActivityIndicator():CircularProgressIndicator(),
                                ),
                              );
                            }else if (state is BatchErrorState)
                            {
                              return Center(child: Text('error',textAlign: TextAlign.center,style: TextStyle(fontSize: 13,color: Colors.black54),),);
                            }else if (state is BatchSuccessState)
                            {
                              if(state.length == 0)
                                return Center(child: Text('error',textAlign: TextAlign.center,style: TextStyle(fontSize: 13,color: Colors.black54),),);
                              else  return SizedBox.shrink();
                            }
                            else  return SizedBox.shrink();

                          },);
                      }
                      return  GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, QuestionRoutes.QUESTION_DETAIL_SCREEN,arguments: questions[index].id);
                        },
                        child: Container(
                          height: 130,
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius:1,
                                  spreadRadius: 1
                              )
                            ],
                            color:   Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Icon(questions[index].is_answered?Icons.check:Icons.close , color: questions[index].is_answered?Colors.green:Colors.red,size: 24,) ,
                                  ),
                                  SizedBox(width: 16.0,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Title : '+questions[index].title ,maxLines: 3 ,style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500
                                        ),),



                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15,),

                                ],
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.remove_red_eye,color: Colors.blue,),
                                      SizedBox(width: 5.0,),
                                      Text(questions[index].view_count.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0))
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.score,color: Colors.yellow,),
                                      SizedBox(width: 5.0,),
                                      Text(questions[index].score.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0))
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.question_answer_outlined , color: Colors.blue,),
                                      SizedBox(width: 5.0,),
                                      Text(questions[index].answer_count.toString() ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0),)
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 4,),


                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );}
          else  return Center(
              child: Container(
                width: 30,
                height: 30,
                child: Platform.isIOS?CupertinoActivityIndicator(): CircularProgressIndicator(),
              ),
            );

        }
    );
  }


}
