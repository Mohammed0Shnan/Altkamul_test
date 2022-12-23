
import 'package:altkamul_test/di/components/app.component.dart';
import 'package:altkamul_test/main.dart';
import 'package:altkamul_test/module_home/navigator_module.dart';
import 'package:altkamul_test/module_home/screen/home_screen.dart';
import 'package:altkamul_test/module_home/screen/navigator_screen.dart';
import 'package:altkamul_test/module_offline_mode/bloc/connection_bloc.dart';
import 'package:altkamul_test/module_question/question_module.dart';
import 'package:altkamul_test/module_question/ui/screens/question_detail.dart';
import 'package:altkamul_test/module_splash/screen/splash_screen.dart';
import 'package:altkamul_test/module_splash/splash_module.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AppComponentInjector implements AppComponent {
  AppComponentInjector._();

  static Future<AppComponent> create() async {
    final injector = AppComponentInjector._();
    return injector;
  }

  MyApp _createApp() => MyApp(
      _createSplashModule(),
      _createNavigatorModule(),
      _createQuestionModule(),
      _createInternetService()
  );


  SplashModule _createSplashModule() =>
      SplashModule(SplashScreen());
  NavigatorModule _createNavigatorModule() {
    return NavigatorModule( NavigatorScreen(
        homeScreen: HomeScreen(),
    ),
    );
  }
  QuestionModule _createQuestionModule() =>
      QuestionModule(OrderDetailScreen());

  InternetService _createInternetService()=> InternetService(Connectivity());

  MyApp get app {
    return _createApp();
  }
}
