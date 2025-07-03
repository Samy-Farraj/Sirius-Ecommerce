import 'package:flutter/cupertino.dart';

class CustomImageWidget extends StatelessWidget {
  final String imageUrl;
  final String staticImageUrl;
  final double height;
  final double width;

  const CustomImageWidget(
      {super.key,
      required this.imageUrl,
      required this.staticImageUrl,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {


    return Image.network(
 fit: BoxFit.cover,
      height: height,
      width: width,
      imageUrl.toString(),
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        // Error occurred while loading image from the server.
        // You can return a widget that displays the static image here.
        return Image.asset(
          fit: BoxFit.cover,
            height: height,
            width: width,
            staticImageUrl); // Assuming you have the static image in your assets.
      },
    );
  }
}
