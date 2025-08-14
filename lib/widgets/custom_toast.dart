import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  final String message;
  
  const CustomToast({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: MediaQuery.of(context).size.width * 0.5 - 100,
      right: MediaQuery.of(context).size.width * 0.5 - 100,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(message),
        )
      ),
    );
  }
}
