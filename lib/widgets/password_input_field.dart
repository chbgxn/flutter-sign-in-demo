import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordInputField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  const PasswordInputField({super.key, required this.controller});

  @override
  ConsumerState<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends ConsumerState<PasswordInputField> {
  bool _showPwd = false;

  @override
  Widget build(BuildContext context) {
    // final signInStateNotifier = ref.read(signInNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: !_showPwd,
          decoration: InputDecoration(
          hintText: '请输入您的密码',
          suffixIcon: _showPwd
            ? IconButton(
                onPressed: () => setState(() => _showPwd = false),
                icon: Icon(Icons.visibility)
              )
            : IconButton(
                onPressed: () => setState(() => _showPwd = true),
                icon: Icon(Icons.visibility_off)
              )
            ,
            border: OutlineInputBorder()
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}