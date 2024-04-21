import 'package:flutter/material.dart';
import 'package:hello_world/screen/dice/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController!.addListener(tabListener);
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

  @override
  void dispose() {
    _tabController!.removeListener(tabListener);
    _tabController!.dispose();
    super.dispose();
  }

  List<Widget> renderChildren() {
    return [
      const HomeScreen(number: 1),
      'Tab2'.text.color(Colors.white).make().centered(),
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
}
