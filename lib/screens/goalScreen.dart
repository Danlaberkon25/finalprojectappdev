import 'package:flutter/material.dart';
import 'package:myfirstapp/dialogs/testing.dart';
import 'package:myfirstapp/dialogs/withdrawSavingDialog.dart';
import 'package:myfirstapp/models/goal.dart';
import 'package:myfirstapp/screens/HomeScreen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:myfirstapp/dialogs/addSavingDialog.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';
import 'package:myfirstapp/dialogs/editGoalDialog.dart';
import 'package:myfirstapp/method/GoalScreenMethod.dart';
import 'package:intl/intl.dart';

class GoalScreen extends StatefulWidget {

  final int index;

  const GoalScreen({super.key,required this.index});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {




  @override
  Widget build(BuildContext context) {
    final goal = context.watch<GoalProvider>().goals[widget.index];
    final method = MethodEditGoal();
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
    final goalName = goal.goalName;
    final goalAmount = goal.goalAmount;
    final goalProgress = goal.goalProgress;
    final goalRemaining = goal.goalRemaining;
    final note = goal.note;
    final currency = goal.currency;
    final history = goal.goalHistory;

    
    print(method.gettingPercentage(goal));
    return MaterialApp(
      home: DefaultTabController(length: 2,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text("${goalName}"),
                centerTitle: true,
                leading: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                }, icon: Icon(Icons.arrow_back)),
                bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Savings'),
                      Tab(text: 'History'),
                    ]),
                actions: [
                  Padding(padding: EdgeInsets.only(right: 10),
                    child: IconButton(onPressed: (){
                      showDialog(context: context,
                        builder: (_) => EditGoalDialog(index: widget.index),);
                      print("Hello world");
                    }, icon: Icon(Icons.edit_square)),),
                ],
              ),
              body:TabBarView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child:Padding(padding: EdgeInsets.all(10),
                            child: CircularPercentIndicator(
                              radius: 100.0,
                              lineWidth: 20,
                              percent: method.gettingPercentage(goal),
                              center: Image.asset('assets/milk-mocha.gif',width: 100,),
                              backgroundColor: Colors.redAccent,
                              progressColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.only(right: 40),
                              child: Text('🔴Remaining Amount',
                                style: TextStyle(fontSize: 12),),),
                              Padding(padding: EdgeInsets.only(left: 40),
                              child:  Text('🔵Progress Amount',
                                  style: TextStyle(fontSize: 12)),)
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        method.displaySaved(goal),
                        SizedBox(height: 10,),
                        method.displayRemainingandAmount(goal),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(onPressed: (){
                              showDialog(context: context,
                                  builder: (_) => AddSavingDialog(index: widget.index));
                            },
                              child: Text('Add Savings',
                                style: TextStyle(color: Colors.green),
                              ),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[50]),),
                            ElevatedButton(onPressed: (){
                              showDialog(context: context,
                                  builder: (_) => withdrawSavingDialog(index: widget.index));
                            },
                              child: Text('Withdraw Savings',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink[100]),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                if (goal.goalHistory.length == 0) Column(
                  children: [
                   Padding(padding: EdgeInsets.only(top:100),
                   child:  Image.asset('assets/noo-Goal.gif',
                       height: 200,
                       width: 200),),
                    Center(
                      child: Padding(padding: EdgeInsets.all(20),
                          child:Text('No History',
                              style: TextStyle(fontSize: 20),),
                    ))
                  ]
                ) else ListView.builder(
                  itemCount: history.length,
                    itemBuilder:(context,index){
                      final historyIndex = history[index];
                      print('hello${history[index]['amount']}');
                      print('${historyIndex}');
                      return method.historyContainer(goal, index);
                    }
                    ),
              ],
              ),
      )
      ),


    );
  }
}