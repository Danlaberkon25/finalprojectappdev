import 'package:flutter/material.dart';
import 'package:myfirstapp/ScreenUI/GoalScreenUI.dart';
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
          appBar: appBarWidget(goal: goal),
          body:TabBarView(children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: ContainerShadow(),
                child: Column(
                  children: [
                    SavingsIndicator(goal: goal),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          remainingAmountLabel(),
                          progressAmountLabel(),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SavingsContainer(goal: goal),
                        GoalAmountContainer(goal: goal)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AddSavingButton(goal:goal),
                        WithdrawSavingButton(goal: goal),
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