import 'package:flutter/material.dart';
import 'package:minapharm_flutter_task/config/constants/pallete.dart';

class AuthButton extends StatelessWidget {
  final String btnTitle;
  final Function() onPressed;
  const AuthButton({Key? key, required this.btnTitle, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        btnTitle,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(274, 45),
        primary: Pallete.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(44),
        ),
      ),
    );
  }
}
