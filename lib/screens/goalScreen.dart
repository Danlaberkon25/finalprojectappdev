import 'package:flutter/material.dart';
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

  final Goal goal;

  const GoalScreen({super.key,required this.goal});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {




  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GoalProvider>();

    final goal = provider.goals.firstWhere(
          (goal) => goal == widget.goal,
    );
    final method = GoalScreenMethod();
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
    final goalName = goal.goalName;
    final goalAmount = goal.goalAmount;
    final goalProgress = goal.goalProgress;
    final currency = goal.currency;
    final history = goal.goalHistory;


    print(method.gettingPercentage(goal));
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("${goalName}",
            style: TextStyle(fontFamily: 'roboto', fontWeight: FontWeight.bold),),
            centerTitle: true,
            leading: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back)),
            bottom: const TabBar(
                tabs: [
                  Tab(text: 'Savings'),
                  Tab(text: 'History'),
                ]),
            actions: [
              Padding(padding: EdgeInsets.only(right: 10),
                child: IconButton(onPressed: () {
                  showDialog(context: context,
                    builder: (_) => EditGoalDialog(goal: widget.goal),);
                  print("Hello world");
                }, icon: Icon(Icons.edit_square)),),
            ],
          ),
          body: TabBarView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(50, 50, 93, 0.25),
                          blurRadius: 100,
                          spreadRadius: -20,
                          offset: Offset(0, 50),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          blurRadius: 60,
                          spreadRadius: -30,
                          offset: Offset(0, 30),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(10, 37, 64, 0.35),
                          blurRadius: 6,
                          spreadRadius: 0,
                          offset: Offset(0, -2),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                          blurRadius: 0,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(padding: EdgeInsets.all(10),
                          child: CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 20,

                            percent: method.gettingPercentage(goal),
                            center: Column(
                              children: [
                                
                                Padding(padding: EdgeInsets.only(top: 45),
                                  child: Image.asset(
                                    'assets/milk-mocha.gif', width: 100,),
                                ),
                                Padding(padding: EdgeInsets.only(top: 5),
                                child: Text('${method.gettingPercentage(goal) * 100}%'),),

                              ],
                            ),
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
                              child: Text('🔵Progress Amount',
                                  style: TextStyle(fontSize: 12)),)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      method.displaySavedAndGoalContainer(goal),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(onPressed: () {
                            showDialog(context: context,
                                builder: (_) => AddSavingDialog(goal: goal));
                          },
                            child: Text('Add Savings',
                              style: TextStyle(color: Colors.green),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[50]),),
                          ElevatedButton(onPressed: () {
                            if(goal.goalProgress <= 0){
                              GoalScreenMethod().showMessageBox(context);
                            }else{
                              showDialog(context: context, builder: (_) => withdrawSavingDialog(goal: goal));
                            }

                          },
                            child: Text('Withdraw Savings',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink[100]),),
                              
                          
                        ],
                        
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                )

              ],
            ),
            if (goal.goalHistory.length == 0) Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 100),
                    child: Image.asset('assets/noo-Goal.gif',
                        height: 200,
                        width: 200),),
                  Center(
                      child: Padding(padding: EdgeInsets.all(20),
                        child: Text('No History',
                          style: TextStyle(fontSize: 20),),
                      ))
                ]
            ) else
              ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final historyIndex = history[index];
                    print('hello${history[index]['amount']}');
                    print('${historyIndex}');
                    return method.historyContainer(goal, index);
                  }
              ),
          ],
          ),

        )
    );
  }
}