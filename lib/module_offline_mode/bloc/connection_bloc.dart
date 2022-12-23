import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


abstract class InternetState{}
class InternetConnected extends InternetState{
  InternetConnected();
}
class InternetDisConnected extends InternetState{
  InternetDisConnected();
}
class InternetLoading extends InternetState{
  InternetLoading();
}
class InternetService extends Cubit<InternetState>{
  final Connectivity connectivity;
  late final StreamSubscription connectivitySubscription  ;
  InternetService(this.connectivity):super(InternetLoading()){
    connectivitySubscription = connectivity.onConnectivityChanged.listen((event) {
      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      print(event.toString());
      if(event == ConnectivityResult.wifi || event == ConnectivityResult.mobile){
        emitInternetConnected();
      }else{
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected() => emit(InternetConnected());

  void emitInternetDisconnected() => emit(InternetDisConnected());

}