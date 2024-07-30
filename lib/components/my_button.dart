import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String buttonText = '';
  void Function() onTap;
  MyButton({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Text(buttonText),
          ),
        ),
      ),
    );
  }
}
