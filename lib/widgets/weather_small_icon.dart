// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'image_wather_code.dart';

class WeatherSmallIcon extends StatelessWidget {
  final String? iconImage;
  final int? codeWeather;
  final double size;
  final String text1;
  final String text2;
  const WeatherSmallIcon({
    Key? key,
    this.iconImage,
    this.codeWeather,
    required this.size,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildImageWeather(),
        const SizedBox(width: 2),
        Column(
          children: [
            Text(
              text1,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400),
            ),
            Text(
              text2,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w200),
            )
          ],
        )
      ],
    );
  }

  Widget _buildImageWeather() {
    if (iconImage != null) {
      return Image.asset(
        iconImage!,
        scale: size.toDouble(),
      );
    } else if (codeWeather != null) {
      return ImageWatherCode(
        codeWeather: codeWeather!,
        scale: size.toInt(),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Icon(
          Icons.error,
          size: 40,
          color: Colors.red,
        ),
      );
    }
  }
}
