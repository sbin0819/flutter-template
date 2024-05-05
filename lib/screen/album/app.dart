import 'package:flutter/material.dart';
import 'package:hello_world/screen/album/home_screen.dart';

class AlbumApp extends StatelessWidget {
  const AlbumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
