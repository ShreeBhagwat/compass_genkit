import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor = Colors.black,
  });
  final String buttonText;
  final void Function()? onPressed;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          shadowColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.primaryContainer),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            buttonColor,
          ),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ));
  }
}
