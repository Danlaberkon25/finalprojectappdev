import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:myfirstapp/dialogs/withdrawSavingDialog.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    if (goal.goalProgress > goal.goalAmount) {
      return Colors.redAccent;
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

  /// History Goal Amount Style
  Widget historyGoalAmountStyle(goal, int index) {
    final item = goal.goalHistory[index];

    if (item['operator'] == 'add') {
      return Text(
        '+ ${goal.currency} ${double
            .parse(item['amount'].toString())
            .toStringAsFixed(2)}',
        style: const TextStyle(
            color: Colors.green,
            fontSize: 16,
            fontFamily: 'roboto',
            fontWeight: FontWeight.bold
        ),
      );
    } else {
      return Text(
        '- ${goal.currency} ${double
            .parse(item['amount'].toString())
            .toStringAsFixed(2)}',
        style: const TextStyle(
            color: Colors.redAccent,
            fontSize: 16,
            fontFamily: 'roboto',
            fontWeight: FontWeight.bold
        ),
      );
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

  // Display Saved and Goal Container
  Widget displaySavedAndGoalContainer(goal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
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
                            color: colorValidationSaved(goal),
                            fontFamily: 'roboto'),
                      ),),

                  ]
              ),
            ),
            Container(
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
            )
          ],
        )

      ],
    );
  }

  ////Message Box for Withdraw Savings
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


  /// History container
  Widget historyContainer(goal, int index) {
    final item = goal.goalHistory[index];
    if (item['note'] == ' ' || item['note'].length == 0) {
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
                  child: Text('${item['date']}'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 5, bottom: 10),
                  child: GoalScreenMethod().historyGoalAmountStyle(goal, index),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
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
                  child: Text('${item['date']}'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 5),
                  child: GoalScreenMethod().historyGoalAmountStyle(goal, index),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 1, left: 10),
              child: Text('Note: ${item['note']}'),
            ),
          ],
        ),
      );
    }
  }
}
