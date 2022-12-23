
import 'package:altkamul_test/module_home/navigator_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  SplashScreen(
  );
 
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getNextRoute().then((route) async{
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
    );
  }

  Future<String> _getNextRoute() async {

        return NavigatorRoutes.NAVIGATOR_SCREEN;

  }
}


