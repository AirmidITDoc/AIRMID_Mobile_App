import 'package:flutter/material.dart';

class DefualtTabBarExample extends StatefulWidget {
  const DefualtTabBarExample({super.key});

  @override
  State<DefualtTabBarExample> createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<DefualtTabBarExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            Center(
              child: Text("Home"),
            ),
            Center(
              child: Text("Profile"),
            ),
            Center(
              child: Text("Setting"),
            ),
          ],
        ),
      ),
    );
  }
}
