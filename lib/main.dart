import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_demo/widgets/custom_toast.dart';
import 'package:sign_in_demo/providers/providers.dart';
import 'package:sign_in_demo/screens/sign_in_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toastStateNotifier = ref.watch(toastStateNotifierProvider);
    return MaterialApp(
      home: SignInScreen(),
      builder: (context, child){
        return Stack(
          children: [
            child!,
            toastStateNotifier.isShow
             ? CustomToast(message: toastStateNotifier.message)
             : SizedBox()
          ],
        );
      },
    );
  }
}