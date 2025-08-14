import 'package:sign_in_demo/models/sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_demo/providers/providers.dart';

class SignInStateNotifier extends AutoDisposeNotifier<SignInState> {

  @override
  SignInState build() => SignInState();

  void updateInput(String email, String password){
    state = state.copyWith(
      email: email, 
      password: password,
      emailError: validateEmail(email), 
      passwordError: validatePassword(password),
      buttonEnable: false
    );
  }

  void clearEmail(){
    state = state.copyWith(email: '', emailError: '');
  }

  Future<void> signIn(String email, String password) async{
    final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
    updateInput(email, password);
    
    if(state.emailError.isEmpty && state.passwordError.isEmpty){  
      state = state.copyWith(buttonEnable: true);
      await authStateNotifier.signIn(email: email, password: password);
      state = state.copyWith(
        buttonEnable: false,
        email: '',
        password: '',
        emailError: '',
        passwordError: ''
      );
    }
    else if(state.emailError.isNotEmpty){
      ref.read(toastStateNotifierProvider.notifier).show(state.emailError);
    }
    else if(state.passwordError.isNotEmpty){
      ref.read(toastStateNotifierProvider.notifier).show(state.passwordError);
    }
  }
}

String? validateEmail(String email){
  if(email.isEmpty){
    return '';
  }
  if(!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)){
    return '请输入有效的邮箱地址';
  }
  return '';
}

String? validatePassword(String password){
  if(password.isEmpty){
    return '';
  }
  if(password.trim().length < 6){
    return '密码小于6位';
  }
  return '';
}