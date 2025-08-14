import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_demo/models/auth_state.dart';
import 'package:sign_in_demo/models/user.dart';
import 'package:sign_in_demo/network/app_exception.dart';
import 'package:sign_in_demo/providers/providers.dart';

class AuthStateNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => AuthState();

  Future<void> signIn({required String email, required String password}) async {
    final apiService = ref.watch(apiServiceProvider);
    
    state = state.copyWith(isLoading: true);

    try{
      final response = await apiService.post(data: {
        'email':email,
        'password': password
      });
      state = state.copyWith(
        currentUser: User(
          email: response.data['data']['userInfo']['email'],
          name: response.data['data']['userInfo']['name']
        ),
        isLoading: false,
        hasError: false,
        errorMsg: ''
      );
    } on DioException catch(e){
      late final String errorMsg;
      if(e.error is AppException){
        final appError = e.error as AppException;
        errorMsg = appError.message;
      }
      else{
        errorMsg = '未知错误';
      }
      state = state.copyWith(
        isLoading: false, 
        hasError: true,
        errorMsg: errorMsg
      );
      ref.read(toastStateNotifierProvider.notifier).show(state.errorMsg);
    }
  }
}