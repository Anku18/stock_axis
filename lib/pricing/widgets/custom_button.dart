import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final Function() onPressed;
  const CustomButton(
      {super.key, required this.buttonTitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            backgroundColor: const Color(0xff18388F),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
        onPressed: onPressed,
        child: Text(
          buttonTitle,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ));
  }
}
