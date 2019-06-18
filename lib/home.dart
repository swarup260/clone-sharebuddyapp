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
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[MapTab(), ListTab(), SettingTab()],
        controller: controller,
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Icon(
                Icons.map,
                // color: Theme.of(context).primaryIconTheme.color,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.format_list_bulleted,
                // color: Theme.of(context).primaryIconTheme.color,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.settings,
                // color: Theme.of(context).primaryIconTheme.color,
              ),
            )
          ],
          // setup the controller
          controller: controller,
          unselectedLabelColor: Theme.of(context).hintColor,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Theme.of(context).primaryIconTheme.color,
        ),
      ),
    );
  }
}
