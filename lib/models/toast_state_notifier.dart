import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_demo/models/toast_state.dart';

class ToastStateNotifier extends Notifier<ToastState> {

  @override
  ToastState build() => ToastState();
  
  void show(String message){
    state = state.copyWith(message: message, isShow: true);

    Future.delayed(Duration(seconds: 2), (){
      state = state.copyWith(message: '', isShow: false);
    });
  }

  void hide(){
    state = state.copyWith(message: '', isShow: false);
  }
}