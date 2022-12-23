
import 'dart:async';
import 'package:altkamul_test/di/components/app.component.dart';
import 'package:altkamul_test/module_home/navigator_module.dart';
import 'package:altkamul_test/module_offline_mode/bloc/connection_bloc.dart';
import 'package:altkamul_test/module_question/question_module.dart';
import 'package:altkamul_test/module_splash/splash_module.dart';
import 'package:altkamul_test/module_splash/splash_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /// di
  final container = await AppComponent.create();

/// Your App Is Here ...
  runApp( container.app,);
}



class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  final SplashModule _splashModule;
  final NavigatorModule _navigatorModule;
  final QuestionModule _questionModule;
  final InternetService internetService;
  MyApp(this._splashModule, this._navigatorModule,this._questionModule,this.internetService);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
Timer? _timer;
  @override
  void initState() {


    super.initState();
  }

@override
void deactivate() {

  super.deactivate();
}
  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routes = {};
    routes.addAll(widget._splashModule.getRoutes());
    routes.addAll(widget._navigatorModule.getRoutes());
    routes.addAll(widget._questionModule.getRoutes());
    return FutureBuilder<Widget>(
      initialData: Container(color: Colors.green),
      future: configuratedApp(routes),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        return snapshot.data!;
      },
    );
  }

  Future<Widget> configuratedApp(Map<String, WidgetBuilder> routes,) async {

    return  BlocProvider<InternetService>(
      create: (context) => widget.internetService ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Al Tkamul',
        routes: routes,
        initialRoute: SplashRoutes.SPLASH_SCREEN,
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}

class AppObserver extends BlocObserver {

}
