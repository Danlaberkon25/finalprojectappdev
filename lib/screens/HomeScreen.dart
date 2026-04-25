import 'package:flutter/material.dart';
import 'package:myfirstapp/method/HomeScreenMethod.dart';
import 'package:myfirstapp/ScreenUI/HomeScreenUI.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final homeMethod = Homescreenmethod();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      resizeToAvoidBottomInset: true,
      drawer: AppDrawer(),
      appBar: appBar(),
      body: Body(),
      floatingActionButton: FloatingAddGoalButton(),
    );

  }
}