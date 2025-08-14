import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_demo/providers/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: Text('首页')),
      body: Center(
        child: Text('欢迎来到首页, ${authState.currentUser!.name}'),
      ),
    );
  }
}