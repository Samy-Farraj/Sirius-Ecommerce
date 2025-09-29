import 'package:flutter/material.dart';

class CircleImagesWidget extends StatelessWidget {
  const CircleImagesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return SizedBox(
      height: size.height * 0.45,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size.width * 0.85,
            height: size.width * 0.85,
            child: Image.asset(
              'assets/images/e.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            child: SizedBox(
              width: size.width * 0.30,
              height: size.width * 0.30,
              child: Image.asset(
                'assets/images/s.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.07,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: size.width * 0.4,
                height: size.height * 0.43,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/w1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            right: size.width * 0.045,
            top: size.height * 0.015,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: size.width * 0.35,
                height: size.height * 0.21,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/w2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            right: size.width * 0.045,
            bottom: size.height * 0.01,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: size.width * 0.35,
                height: size.height * 0.21,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/w3.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 