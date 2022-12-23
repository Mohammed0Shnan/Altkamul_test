import 'package:altkamul_test/abstracts/module/my_module.dart';
import 'package:altkamul_test/module_home/navigator_routes.dart';
import 'package:altkamul_test/module_home/screen/navigator_screen.dart';
import 'package:flutter/material.dart';

class NavigatorModule extends MyModule {
  final NavigatorScreen _navigatorScreen;
  NavigatorModule(this._navigatorScreen);
  @override
  Map<String, WidgetBuilder> getRoutes() => {
        NavigatorRoutes.NAVIGATOR_SCREEN: (context) => _navigatorScreen,
      };
}
