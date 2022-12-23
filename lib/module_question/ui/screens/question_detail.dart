
import 'dart:io';

import 'package:altkamul_test/module_question/model/question_model.dart';
import 'package:altkamul_test/module_question/state_manager/question_detail_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';



class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late final QuestionDetailBloc _detailBloc;
  late int orderID;
@override
  void initState() {
  _detailBloc = QuestionDetailBloc();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    String _id = ModalRoute.of(context)!.settings.arguments.toString();
    orderID = int.parse(_id);
    _detailBloc.getQDetail( qId: orderID);

  });

    super.initState();
  }
  @override
  void dispose() {
    _detailBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:   Text('Details',style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
          elevation: 0,
      ),
      body:  BlocBuilder<QuestionDetailBloc , QuestionDetailStates>(
        bloc: _detailBloc,
        builder: (context,state) {
          if(state is QuestionDetailErrorState)
            return Center(
              child: Container(
                child: Text(state.message),
              ),
            );
          else if(state is QuestionDetailSuccessState){
            QuestionModel question = state.data;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1,
                              offset: Offset(0,1)
                          )]
                      ),
                      child: Center(child: Text('Score :  '+question.score.toString(),
                        style: TextStyle(
                              fontSize:14,
                              color: Colors.black87,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600)
                      ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1,
                              offset: Offset(0,1)
                          )]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.description,color: Colors.blue,),
                              SizedBox(width: 5,),
                              Text('Title',style: TextStyle(
                                  fontSize:14,
                                  color: Colors.black87,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600),),


                            ],
                          ),
                          SizedBox(height: 8,),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                            child:Text(question.title,style: TextStyle(
                                fontSize: 13,
                                color: Colors.black45,
                                fontWeight: FontWeight.w800
                            )),
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 12,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1,
                              offset: Offset(0,1)
                          )]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.date_range,color: Colors.blue,),
                              SizedBox(width: 5,),
                              Text('Posted Date',style: TextStyle(
                                  fontSize:14,
                                  color: Colors.black87,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600),),


                            ],
                          ),
                          SizedBox(height: 8,),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                            child:Text(question.creation_date.toString(),style: TextStyle(
                                fontSize: 13,
                                color: Colors.black45,
                                fontWeight: FontWeight.w800
                            )),
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 12,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1,
                              offset: Offset(0,1)
                          )]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.remove_red_eye,color: Colors.blue,),
                              SizedBox(width: 5,),
                              Text('View Count',style: TextStyle(
                                  fontSize:14,
                                  color: Colors.black87,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600),),


                            ],
                          ),
                          SizedBox(height: 8,),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                            child:Text(question.view_count.toString(),style: TextStyle(
                                fontSize: 13,
                                color: Colors.black45,
                                fontWeight: FontWeight.w800
                            )),
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 12,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1,
                              offset: Offset(0,1)
                          )]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.tag,color: Colors.blue,),
                              SizedBox(width: 5,),
                              Text('Tags',style: TextStyle(
                                  fontSize:14,
                                  color: Colors.black87,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600),),


                            ],
                          ),
                          SizedBox(height: 8,),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                            child:Text(question.tags.toString(),style: TextStyle(
                                fontSize: 13,
                                color: Colors.black45,
                                fontWeight: FontWeight.w800
                            )),
                          )

                        ],
                      ),
                    ),

                    SizedBox(height: 12,),
                    GestureDetector(
                      onTap: (){
                         launchUrl(Uri.parse(question.link));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [BoxShadow(
                                color: Colors.black12,
                                blurRadius: 1,
                                offset: Offset(0,1)
                            )]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.link,color: Colors.blue,),
                                SizedBox(width: 5,),
                                Text('Link',style: TextStyle(
                                    fontSize:14,
                                    color: Colors.black87,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w600),),


                              ],
                            ),
                            SizedBox(height: 8,),
                            Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                              child:Text(question.link.toString(),style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w800
                              )),
                            )

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          else {
            return Center(
              child: Container(
                width: 30,
                height: 30,
                child:Platform.isIOS?CupertinoActivityIndicator(): CircularProgressIndicator() ,
              ),
            );
          }
        }
      ),
    );
  }


}
