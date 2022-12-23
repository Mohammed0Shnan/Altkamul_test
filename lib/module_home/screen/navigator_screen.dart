
import 'package:altkamul_test/module_home/screen/home_screen.dart';
import 'package:flutter/material.dart';

class NavigatorScreen extends StatefulWidget {
  final HomeScreen homeScreen;

  NavigatorScreen(
      {required this.homeScreen,
        Key? key})
      : super(key: key);

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int current_index = 0;

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      bottom: true, /// For IOS
      child: Scaffold(

          body: widget.homeScreen,

    ));

  }

 _getActiveScreen(){
    switch(current_index){

       case 0 : {

           return widget.homeScreen;
      }


    }
  }
}




