import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hello_world/screen/dice/home_screen.dart';
import 'package:hello_world/screen/dice/settings_screen.dart';
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  double threshold = 2.7;
  int number = 1;
  ShakeDetector? shakeDetector;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(tabListener);

    shakeDetector = ShakeDetector.autoStart(
      shakeSlopTimeMS: 100,
      shakeThresholdGravity: threshold,
      onPhoneShake: onPhoneShake,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  void tabListener() {
    setState(() {});
  }

  List<Widget> renderChildren() {
    return [
      HomeScreen(number: number),
      SettingsScreen(
        threshold: threshold,
        onThresholdChanged: onThresholdChanged,
      ),
    ];
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _tabController!.index,
      onTap: (index) {
        setState(() {
          _tabController!.animateTo(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.edgesensor_high_outlined),
          label: '주사위',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '설정',
        ),
      ],
    );
  }

  void onThresholdChanged(double value) {
    setState(() {
      threshold = value;
    });
  }

  void onPhoneShake() {
    final random = Random();
    setState(() {
      number = random.nextInt(6) + 1;
    });
  }

  @override
  void dispose() {
    _tabController!.removeListener(tabListener);
    _tabController!.dispose();
    shakeDetector!.stopListening();
    super.dispose();
  }
}
