import 'package:flutter/material.dart';
import 'package:GoSaver/dialogs/withdrawSavingDialog.dart';
import 'package:GoSaver/models/goal.dart';
import 'package:GoSaver/screens/HomeScreen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:GoSaver/dialogs/addSavingDialog.dart';
import 'package:GoSaver/providers/GoalProvider.dart';
import 'package:GoSaver/dialogs/editGoalDialog.dart';
import 'package:GoSaver/method/GoalScreenMethod.dart';
import 'package:intl/intl.dart';

/// App Bar Widget
class appBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Goal goal;
  @override
  Size get preferredSize => const Size.fromHeight(90.0);

  const appBarWidget({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text("${goal.goalName}",
        style: TextStyle(fontFamily: 'roboto', fontWeight: FontWeight.bold,color: Colors.white),),
      centerTitle: true,
      leading: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back),color: Colors.white,),
      bottom: const TabBar(
        labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Savings'),
            Tab(text: 'History'),
          ]),
      actions: [
        Padding(padding: EdgeInsets.only(right: 10),
          child: IconButton(onPressed: () {
            showDialog(context: context,
              builder: (_) => EditGoalDialog(goal: goal),);
            print("Hello world");
          }, icon: Icon(Icons.edit_square),color: Colors.white,),),
      ],
    );
  }
}

/// Container Shadow
Decoration ContainerShadow(){
  return BoxDecoration(
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
  );
}

/// Remaining Amount Label Bullet
Widget remainingAmountLabel(){
  return Padding(padding: EdgeInsets.only(right: 40),
    child: Text('🔴Remaining Amount',
      style: TextStyle(fontSize: 12),
    ),
  );
}
/// Progress Amount Label Bullet
Widget progressAmountLabel(){
  return Padding(padding: EdgeInsets.only(left: 40),
    child: Text('🔵Progress Amount',
        style: TextStyle(fontSize: 12)
    ),
  );
}

/// Savings Indicator Creating State
class SavingsIndicator extends StatefulWidget {
  final Goal goal;

  const SavingsIndicator({super.key, required this.goal});

  @override
  _SavingsIndicator createState() => _SavingsIndicator();
}
///  Savings Indicator UI
class _SavingsIndicator extends State<SavingsIndicator> {
  @override
  Widget build(BuildContext context) {
    final goal = widget.goal;
    final method = GoalScreenMethod();
    return Align(
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
    );
  }
}


/// Savings Container Creating State
class SavingsContainer extends StatefulWidget{
  final Goal goal;
  const SavingsContainer({super.key,required this.goal});
  @override
  _SavingsContainer createState() => _SavingsContainer();
}

/// Savings  Container UI
class _SavingsContainer extends State<SavingsContainer>{
  @override
  Widget build(BuildContext context) {
    final goal = widget.goal;
    final method = GoalScreenMethod();
    final formatter = NumberFormat('#,##0.00');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20,right: 10),
            child: Container(
              margin: EdgeInsets.only(left: 20),
              width: 150,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text('Saved', style: TextStyle(fontSize: 15),),),
                    Padding(padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                      child: Text(
                        '${goal.currency} ${formatter.format(
                            goal.goalProgress)}',
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: method.colorValidationSaved(goal),
                            fontFamily: 'roboto'),
                      ),),
                  ]
              ),
            ),
            ),
          ],
        )

      ],
    );
  }
}
/// Goal Amount Creating State
class GoalAmountContainer extends StatefulWidget{
  final Goal goal;
  const GoalAmountContainer({super.key,required this.goal});
  @override
  _GoalAmountContainer createState() => _GoalAmountContainer();
}

/// Goal Amount Container UI
class _GoalAmountContainer extends State<GoalAmountContainer>{
  @override
  Widget build(BuildContext context) {
    final goal = widget.goal;
    final formatter = NumberFormat('#,##0.00');
    return Container(
      margin: EdgeInsets.only(left: 20),
      width: 150,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                'Goal Amount', style: TextStyle(fontSize: 15),),),
            Padding(padding: EdgeInsets.only(left: 10, top: 3),
              child: Text(
                '${goal.currency} ${formatter.format(goal.goalAmount)}',
                style: TextStyle(fontSize: 12,
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.bold),),)
          ]
      ),
    );
  }
}

/// Add Saving Button Creating State
class AddSavingButton extends StatefulWidget {
  final Goal goal;
  const AddSavingButton({super.key, required this.goal});
  @override
  _AddSavingButton createState() => _AddSavingButton();
}
/// Add Saving Button UI
class _AddSavingButton extends State<AddSavingButton>{
  @override
  Widget build(BuildContext context) {
    final goal = widget.goal;
    return ElevatedButton(onPressed: () {
      showDialog(context: context,
          builder: (_) => AddSavingDialog(goal: goal));
    },
      child: Text('Add Savings',
        style: TextStyle(color: Colors.green),
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[50]),);
  }
}
/// Withdraw Button Creating State
class WithdrawSavingButton extends StatefulWidget{
  final Goal goal;
  const WithdrawSavingButton({super.key,required this.goal});
  @override
  _WithdrawSavingButton createState() => _WithdrawSavingButton();

}

/// Withdraw Button UI
class _WithdrawSavingButton extends State<WithdrawSavingButton>{
  @override
  Widget build(BuildContext context) {
    final goal = widget.goal;
    return ElevatedButton(onPressed: () {
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
          backgroundColor: Colors.pink[100]),);
  }
}
/// No History Widget
Widget NoHistoryWidget(){
  return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 100),
          child: Image.asset('assets/noo-Goal.gif',
              height: 200,
              width: 200),),
        Center(
            child: Padding(padding: EdgeInsets.all(20),
              child: Text('No History',
                style: TextStyle(fontSize: 20),),
            )
        )
  ]
  );
}
/// Goal History Container With Note Creating State
class GoalHistoryContainerWithNote extends StatefulWidget{
  final Goal goal;
  final int index;
  const GoalHistoryContainerWithNote({super.key,required this.goal,required this.index});
  @override
  _GoalHistoryContainerWithNote createState() => _GoalHistoryContainerWithNote();
}
/// Goal History Container With Note UI
class _GoalHistoryContainerWithNote extends State<GoalHistoryContainerWithNote>{
  @override
  Widget build(BuildContext context) {
    final history = widget.goal.goalHistory[widget.index];
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: const [
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text('${history['date']}'),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, top: 5),
                child: GoalScreenMethod().historyGoalAmountStyle(widget.goal, widget.index),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 1, left: 10),
            child: Text('Note: ${history['note']}'),
          ),
        ],
      ),
    );
  }
}
/// Goal History Container Without Note Creating State
class GoalHistoryContainerWithoutNote extends StatefulWidget{
  final Goal goal;
  final int index;
  const GoalHistoryContainerWithoutNote({super.key,required this.goal,required this.index});
  @override
  _GoalHistoryContainerWithoutNote createState() => _GoalHistoryContainerWithoutNote();

}
//// Goal History Container Without Note UI
class _GoalHistoryContainerWithoutNote extends State<GoalHistoryContainerWithoutNote>{
  @override
  Widget build(BuildContext context) {
    final history = widget.goal.goalHistory[widget.index];
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: const [
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
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text('${history['date']}'),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, top: 5, bottom: 10),
                child: GoalScreenMethod().historyGoalAmountStyle(widget.goal, widget.index),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///History Goal Amount Add Savings Widget
Widget historyGoalAmountAddSavings(currency,amount){
  final formatter = NumberFormat('#,##0.00');
  return Text(
    '+ ${currency} ${formatter.format(amount)}',
    style: TextStyle(
        color: Colors.green,
        fontSize: 16,
        fontFamily: 'roboto',
        fontWeight: FontWeight.bold
    ),
  );
}
/// History Goal Amount Withdraw Widget
Widget historyGoalAmountWithdraw(currency,amount){
  final formatter = NumberFormat('#,##0.00');
  return Text(
    '- ${currency} ${formatter.format(amount)}',
    style: const TextStyle(
      color: Colors.redAccent,
      fontSize: 16,
      fontFamily: 'roboto',
      fontWeight: FontWeight.bold,
    ),
  );
}
