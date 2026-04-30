import 'package:flutter/material.dart';
import 'package:GoSaver/method/HomeScreenMethod.dart';
import 'package:GoSaver/ScreenUI/HomeScreenUI.dart';



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
      body: SafeArea(child: Body()),
      floatingActionButton: FloatingAddGoalButton(),
    );

  }
}