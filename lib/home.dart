import 'package:flutter/material.dart';
import 'tabs/map.dart';
import 'tabs/list.dart';
import 'tabs/setting.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// SingleTickerProviderStateMixin is used for animation
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // Create a Tab Controller
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Init the Tab Controller
    controller =  TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  TabBarView(
        children: <Widget>[ MapTab(),  ListTab(),  SettingTab()],
        controller: controller,
      ),
      bottomNavigationBar:  Material(
        color: Colors.yellow,
        child:  TabBar(
          tabs: <Tab>[
             Tab(
              icon:  Icon(
                Icons.map,
                color: Colors.black,
              ),
            ),
             Tab(
              icon:  Icon(
                Icons.format_list_bulleted,
                color: Colors.black,
              ),
            ),
             Tab(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            )
          ],
          // setup the controller
          controller: controller,
          indicatorColor: Colors.black,
        ),
      ),
    );
  }
}
