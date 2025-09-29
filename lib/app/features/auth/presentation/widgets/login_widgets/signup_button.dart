import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const SignupButton({
    super.key,
    this.onPressed, required this.text,
    
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const gradient = LinearGradient(
      colors: [Color(0xFFFA0AF2), Color(0xFF0AFAE3)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.065,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(text,
              style:const TextStyle(
                fontSize: 16,
                  fontFamily: "Montserrat",
                color: Colors.white
              )),
        ),
      ),
    );
  }
}
