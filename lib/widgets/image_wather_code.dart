import 'package:flutter/material.dart';

class ImageWatherCode extends StatelessWidget {
  final int codeWeather;
  final int scale;
  const ImageWatherCode({required this.codeWeather, required this.scale});

  @override
  Widget build(BuildContext context) {
    switch (codeWeather) {
      case 200 && <= 232:
        return Center(
            child: Image.asset('assets/1.png', scale: scale.toDouble()));

      case 300 && <= 321:
        return Center(
            child: Image.asset('assets/2.png', scale: scale.toDouble()));

      case 500 && <= 531:
        return Center(
            child: Image.asset('assets/3.png', scale: scale.toDouble()));

      case 600 && <= 622:
        return Center(
            child: Image.asset('assets/4.png', scale: scale.toDouble()));

      case 701 && <= 781:
        return Center(
            child: Image.asset('assets/5.png', scale: scale.toDouble()));

      case 800 && <= 804:
        return Center(
            child: Image.asset('assets/7.png', scale: scale.toDouble()));

      default:
        return Center(
            child: Image.asset('assets/6.png', scale: scale.toDouble()));
    }
  }
}
