import 'package:sign_in_demo/screens/home_screen.dart';
import 'package:sign_in_demo/widgets/email_input_field.dart';
import 'package:sign_in_demo/widgets/password_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_demo/providers/providers.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _emailNotEmpty = false;
  bool _passwordNotEmpty = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener((){
      _emailController.text.trim().isNotEmpty
        ? setState(() => _emailNotEmpty = true)
        : setState(() => _emailNotEmpty = false);
     
    });
    _passwordController.addListener((){
      _passwordController.text.trim().isNotEmpty
        ? setState(() => _passwordNotEmpty = true)
        : setState(() => _passwordNotEmpty = false);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInState = ref.watch(signInNotifierProvider);
    final signInStateNotifier = ref.read(signInNotifierProvider.notifier);
    final authState = ref.watch(authStateNotifierProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Text('邮箱登录', style: TextStyle(fontSize: 32)),

                EmailInputFiled(controller: _emailController),

                PasswordInputField(controller: _passwordController),

                _emailNotEmpty && _passwordNotEmpty  
                ? OutlinedButton(
                  onPressed: !signInState.buttonEnable
                    ? () async {
                        await signInStateNotifier.signIn(
                          _emailController.text.trim(), 
                          _passwordController.text.trim()
                        );
                        if(context.mounted){
                          if(authState.currentUser != null){
                            Navigator.pushReplacement(
                              context, 
                              MaterialPageRoute(builder: (_) => HomeScreen())
                            );
                          }
                        }
                      } 
                      : (){},
                  
                  child: !signInState.buttonEnable
                    ? Text('登录', style: TextStyle(color: Colors.green))
                    : Text('登录中...', style: TextStyle(color: Colors.black))
                )
                : OutlinedButton(
                  onPressed: (){},
                  child: Text('登录', style: TextStyle(color: Colors.black))
                )
              ],
            ),
          ),
          authState.isLoading
            ? SafeArea(
                child: Center(
                  child: CircularProgressIndicator()
                )
              )
            : SizedBox.shrink()
        ],
      )
    );
  }
}