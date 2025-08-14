import 'package:sign_in_demo/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailInputFiled extends ConsumerStatefulWidget {
  final TextEditingController controller;
  const EmailInputFiled({super.key, required this.controller});

  @override
  ConsumerState<EmailInputFiled> createState() => _EmailInputFiledState();
}

class _EmailInputFiledState extends ConsumerState<EmailInputFiled> {
  bool _showClear = false;


  @override
  Widget build(BuildContext context) {
    final signInStateNotifier = ref.read(signInNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
          hintText: '请输入您的邮箱',
          suffixIcon: _showClear
            ? IconButton(
                onPressed: (){
                  widget.controller.clear();
                  signInStateNotifier.clearEmail();
                },
                icon: Icon(Icons.clear)
              )
            : null,
            border: OutlineInputBorder()
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onChanged: (_){
            widget.controller.text.isNotEmpty
              ? setState(() => _showClear = true)
              : setState(()  => _showClear = false);
          },
        ),
      ],
    );
  }
}