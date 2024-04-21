import 'package:flutter/material.dart';
import 'package:hello_world/screen/dice/const/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  final int number;

  const HomeScreen({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/img/$number.png',
          ),
        ),
        const HeightBox(32.0),
        '행운의 숫자'
            .text
            .color(Colors.white)
            .size(20.0)
            .fontWeight(FontWeight.w700)
            .make(),
        const HeightBox(12.0),
        '$number'
            .text
            .color(primaryColor)
            .size(60.0)
            .fontWeight(FontWeight.w200)
            .make(),
      ],
    );
  }
}
