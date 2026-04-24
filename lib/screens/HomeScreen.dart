import 'package:flutter/material.dart';
import 'package:myfirstapp/dialogs/addGoalDialog.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';
import 'package:myfirstapp/screens/archivedScreen.dart';
import 'package:myfirstapp/screens/goalScreen.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/dialogs/confirmationDeleteDialog.dart';
import 'package:myfirstapp/method/HomeScreenMethod.dart';
import 'package:myfirstapp/dialogs/longPressedDialog.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 30),
          Container(
            height: 200,
            width: 310,
            child: Image.asset('assets/milk-and-mocha.gif'),
          ),
          ListTile(
            leading: const Icon(Icons.archive, color: Colors.blueAccent),
            title: const Text('Archive'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArchivedScreen()),
              );
            },
          ),

        ],
      ),
    );
  }
}

class _HomePage extends State<HomePage> {
  final homeMethod = Homescreenmethod();

  @override
  Widget build(BuildContext context) {
    final goals = context.watch<GoalProvider>().goals;
    final provider = context.watch<GoalProvider>();
    final formatter = NumberFormat('#,##0.00');

    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Goal Dashboard',
          style: TextStyle(fontFamily: 'roboto', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: goals.isEmpty
          ? Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 46),
                child: Image.asset('assets/milk-hi.gif'),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  "Seems like you are new, Let's create your first goal",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            )
          ],
        ),
      )
          : ListView.builder(
        itemCount: goals.length,
        itemBuilder: (context, index) {
          final goal = goals[index];
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoalScreen(goal: goal),
                    ),
                  );
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (_) => Longpresseddialog(goal: goal),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(50, 50, 93, 0.25),
                        blurRadius: 27,
                        spreadRadius: -5,
                        offset: Offset(0, 13),
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        blurRadius: 16,
                        spreadRadius: -8,
                        offset: Offset(0, 8),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.only(left: 10, right: 5, top: 10),
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage('assets/milk-hi.gif'),
                              radius: 30,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 10, top: 8),
                                  child: Text(
                                    '${goal.goalName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: new LinearPercentIndicator(
                                    width: 250,
                                    barRadius: Radius.circular(10),
                                    animation: true,
                                    lineHeight: 10.0,
                                    animationDuration: 2000,
                                    percent: 0.9,
                                    center: Text("${homeMethod.gettingPercentage(goal)}%",
                                    style: TextStyle(fontSize: 7),),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.greenAccent,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 10, top: 2),
                                  child: Row(
                                    children: [
                                      Padding(padding: EdgeInsets.only(right: 3),
                                      child: homeMethod.ExcessSaved(goal),),
                                      Text("/ ${goal.currency}${formatter.format(goal.goalAmount)}")
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 20, bottom: 20),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AddGoalDialog(),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}