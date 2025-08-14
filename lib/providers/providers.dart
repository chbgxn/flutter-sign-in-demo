import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_demo/models/auth_state_notifier.dart';
import 'package:sign_in_demo/models/sign_in_state.dart';
import 'package:sign_in_demo/models/sign_in_state_notifier.dart';
import 'package:sign_in_demo/models/toast_state.dart';
import 'package:sign_in_demo/models/toast_state_notifier.dart';
import 'package:sign_in_demo/network/api_service.dart';

final signInNotifierProvider = AutoDisposeNotifierProvider<SignInStateNotifier, SignInState>(
  () => SignInStateNotifier()
);

final authStateNotifierProvider = NotifierProvider(() => AuthStateNotifier());

final apiServiceProvider = Provider((ref) => ApiService());

final toastStateNotifierProvider = NotifierProvider<ToastStateNotifier, ToastState>(
  () => ToastStateNotifier()
);