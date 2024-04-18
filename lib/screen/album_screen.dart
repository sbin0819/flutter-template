import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      int? nextPage = _pageController.page?.toInt();

      if (nextPage == null) {
        return;
      }

      if (nextPage >= 4) {
        nextPage = 0;
      } else {
        nextPage++;
      }

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [1, 2, 3, 4, 5]
            .map(
              (num) => Image.asset(
                'assets/img/image_$num.jpeg',
                fit: BoxFit.cover,
              ),
            )
            .toList(),
      ),
    );
  }
}
