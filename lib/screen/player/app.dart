import 'package:flutter/material.dart';
import 'package:hello_world/screen/player/home_screen.dart';

class PlayerApp extends StatelessWidget {
  const PlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Player',
      home: HomeScreen(),
    );
  }
}
