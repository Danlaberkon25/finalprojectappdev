import 'package:flutter/material.dart';
import 'package:GoSaver/dialogs/withdrawSavingDialog.dart';
import 'package:intl/intl.dart';
import 'package:GoSaver/ScreenUI/GoalScreenUI.dart';

class GoalScreenMethod {
  final formatter = NumberFormat('#,##0.00');

  /// function for getting percentage
  double gettingPercentage(goal) {
    if (goal.goalAmount == 0) return 0.0;

    final getPercentage = goal.goalProgress / goal.goalAmount;

    if (getPercentage >= 1) {
      return 1.0;
    } else if (getPercentage <= 0) {
      return 0.0;
    } else {
      return double.parse(getPercentage.toStringAsFixed(1));
    }
  }

  // Color style for Saved
  Color colorValidationSaved(goal) {
    if (goal.goalProgress > goal.goalAmount && goal.goalAmount != 0) {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }

  // Color style for add savings
  Color colorValidationAddSaving(goal) {
    if (goal.goalProgress > goal.goalAmount) {
      return Colors.redAccent;
    } else {
      return Colors.black;
    }
  }

  // Color Style for withdraw
  Color colorValidationWithdraw(String operator) {
    if (operator == 'withdraw') {
      return Colors.redAccent;
    } else {
      return Colors.green;
    }
  }



  /// History Goal Amount Style if red or green color style
  Widget historyGoalAmountStyle(goal, int index) {
    final history = goal.goalHistory[index];

    final amount = int.tryParse(history['amount']) ?? 0;
    final formatter = NumberFormat('#,##0.00');
    print('helloooo ${historyGoalAmountAddSavings(goal.currency, amount)}');

    if (history['operator'] == 'add') {

      return historyGoalAmountAddSavings(goal.currency, amount);
    } else {
      return historyGoalAmountWithdraw(goal.currency, amount);
    }
  }

  /// History container Note Condition
  Widget historyContainerCondition(goal, int index) {
    final history = goal.goalHistory[index];
    if (history['note'] == ' ' || history['note'].length == 0) {
      return GoalHistoryContainerWithoutNote(goal: goal, index: index);
    } else {
      return GoalHistoryContainerWithNote(goal: goal, index: index);
    }
  }

  // Remaining method
  int remainingStringMethod(goal) {
    if (goal.goalRemaining < 0) {
      return 0;
    } else {
      return goal.goalRemaining;
    }
  }

  void showMessageBox(BuildContext context) {
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Icon(Icons.warning,color: Colors.redAccent,),),
          content: Padding(padding: EdgeInsets.only(left: 10,top: 10),
            child:Text("You don't have enough balance to withdraw savings!",
              style: TextStyle(fontSize: 15),),),
          actions: <Widget>[
            Center(
              child: ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Okay')),
            ),
          ],
        );
      },
    );
  }
}







