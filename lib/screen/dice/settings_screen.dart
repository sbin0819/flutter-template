import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsScreen extends StatelessWidget {
  final double threshold;
  final ValueChanged<double> onThresholdChanged;

  const SettingsScreen({
    super.key,
    required this.threshold,
    required this.onThresholdChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            '민감도'.text.color(Colors.white).make().pOnly(left: 20.0),
          ],
        ),
        Slider(
          min: 0.1,
          max: 10.0,
          divisions: 101,
          value: threshold,
          onChanged: onThresholdChanged,
          label: threshold.toStringAsFixed(1),
        ),
      ],
    );
  }
}
