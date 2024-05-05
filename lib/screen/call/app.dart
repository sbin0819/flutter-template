import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraApp extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraApp({
    super.key,
    required this.cameras,
  });

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();

    initializeCamera();
  }

  initializeCamera() async {
    try {
      controller = CameraController(
        widget.cameras[0],
        ResolutionPreset.max,
      );

      await controller.initialize();

      setState(() {});
    } catch (e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('Camera access error');
            break;
          default:
            print('Error: $e');
            break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return MaterialApp(
      home: CameraPreview(
        controller,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
