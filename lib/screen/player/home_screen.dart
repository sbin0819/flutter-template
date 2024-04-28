import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_world/screen/player/components/custom_icon_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderEmpty() {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: getBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Logo(
              onTap: onNewVideoPressed,
            ),
            const HeightBox(30.0),
            _AppName(),
          ],
        ));
  }

  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF2A3A7C),
          Color(0XFF000118),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  Widget renderVideo() {
    return Center(
      child: _CustomVideoPlayer(
        video: video!,
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final GestureTapCallback onTap;

  const _Logo({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset('assets/img/logo.png'),
    );
  }
}

class _AppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        'VIDEO'.text.white.fontWeight(FontWeight.w300).size(30.0).make(),
        'PLAYER'.text.white.fontWeight(FontWeight.w700).size(30.0).make(),
      ],
    );
  }
}

class _CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final GestureTapCallback onNewVideoPressed;

  const _CustomVideoPlayer({
    required this.video,
    required this.onNewVideoPressed,
  });

  @override
  State<_CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<_CustomVideoPlayer> {
  bool showControls = false;
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();

    initializeController();
  }

  @override
  void didUpdateWidget(covariant _CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio(
        aspectRatio: videoPlayerController!.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(
              videoPlayerController!,
            ),
            if (showControls)
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Slider(
                value:
                    videoPlayerController!.value.position.inSeconds.toDouble(),
                min: 0,
                max: videoPlayerController!.value.duration.inSeconds.toDouble(),
                onChanged: (value) {
                  videoPlayerController!.seekTo(
                    Duration(
                      seconds: value.toInt(),
                    ),
                  );
                },
              ).px(8.0),
            ),
            Align(
              alignment: Alignment.topRight,
              child: CustomIconButton(
                onPressed: widget.onNewVideoPressed,
                iconData: Icons.photo_camera_back,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconButton(
                    onPressed: onReversePressed,
                    iconData: Icons.rotate_left,
                  ),
                  CustomIconButton(
                    onPressed: onPlayPressed,
                    iconData: videoPlayerController!.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  CustomIconButton(
                    onPressed: onPlayPressed,
                    iconData: Icons.rotate_right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  initializeController() async {
    final controller = VideoPlayerController.file(File(widget.video.path));

    await controller.initialize();

    controller.addListener(videoControllerListener);

    setState(() {
      videoPlayerController = controller;
    });
  }

  void videoControllerListener() {
    setState(() {
      videoPlayerController = videoPlayerController;
    });
  }

  onReversePressed() {
    final currentPosition = videoPlayerController!.value.position;

    Duration position = const Duration();

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - const Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);
  }

  onPlayPressed() {
    final maxPosition = videoPlayerController!.value.duration;
    final currentPosition = videoPlayerController!.value.position;

    Duration position = maxPosition;

    if ((maxPosition - const Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + const Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);
  }

  onForwardPressed() {
    if (videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
    } else {
      videoPlayerController!.play();
    }
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    videoPlayerController?.removeListener(videoControllerListener);
    super.dispose();
  }
}
