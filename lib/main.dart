import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/screen/album/app.dart';

late List<CameraDescription> cameras;

void main() async {
  // runApp(const MaterialApp(
  //   home: WebviewScreen(),
  // ));
  // runApp(const MaterialApp(
  //   home: AlbumScreen(),
  // ));
  // runApp(const DateScreenApp());
  // runApp(const DiceApp());
  // runApp(const PlayerApp());

  // WidgetsFlutterBinding.ensureInitialized();
  // cameras = await availableCameras();
  // runApp(CameraApp(
  //   cameras: cameras,
  // ));

  runApp(const AlbumApp());
}
