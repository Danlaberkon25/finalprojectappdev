import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
class MethodEditGoal{
  // function for getting percentage
  double gettingPercentage(goal){
    final getPercentage = goal.goalProgress / goal.goalAmount;
    if (getPercentage >= 1){
      return 1;
    }else if(getPercentage <= 0){
      return 0.0;
    }
    else{
      return double.parse(getPercentage.toStringAsFixed(1));
    }
  }
  // Color Style for add savings
  Color colorValidationAddSaving(goal){
    if(goal.goalProgress > goal.goalAmount){
      return Colors.redAccent;
    }else{
      return Colors.black;
    }
  }
  // Color Style for withdraw
  Color colorValidationWithdraw(String operator){
    if(operator == 'withdraw'){
      return Colors.redAccent;
    }else{
      return Colors.green;
    }
  }
  // condition for history
  Widget HistoryValidationContainer(goal,index){
    if(goal.history[index]['operator'] == 'add'){
      print("${double.parse(goal.history[index]['amount']).toStringAsFixed(2)}");
      return Text('+ ${goal.currency} ${double.parse(goal.history[index]['amount']).toStringAsFixed(2)}',
        style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),
      );
    }else{
      return Text('- ${goal.currency}${double.parse(goal.history[index]['amount']).toStringAsFixed(2)}',
        style: TextStyle(color: Colors.redAccent,fontSize: 16,fontWeight: FontWeight.bold),
      );
    }
  }
  // condition for remaining
  int RemainingStringMethod(goal){
    if (goal.goalRemaining < 0){
      return 0;
    }else{
      return goal.goalRemaining;
    }
  }
  // widget for displaysaved
  Widget displaySaved(goal) {
    return Column(
      children: [
        Center(
          child: Text('Saved',
            style: TextStyle(fontSize: 18),),
        ),
        Center(
          child: Text(
              '${goal.currency} ${goal.goalProgress.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18)),
        )
      ],
    );
  }

    // displayRemaining
    Widget displayRemainingandAmount(goal) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Remaining',
                  style: TextStyle(fontSize: 18)),
              Text('Goal Amount',
                  style: TextStyle(fontSize: 18))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(margin: EdgeInsets.only(right:40 ),
                child: Text('${goal.currency} ${goal.goalRemaining!.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18,color: MethodEditGoal().colorValidationAddSaving(goal))),),
              Padding(padding: EdgeInsets.only(right: 20),
                child: Text('${goal.currency} ${goal.goalAmount!.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18),),)
            ],
          ),
        ],
      );
    }

    /// History Container
    Widget historyContainer(goal,index){
      return Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.only(left: 10,top: 5),
                  child: Text('${goal.history[index]['date']}')
                  ,),
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(padding: EdgeInsets.only(right: 30,top: 5),
                        child: MethodEditGoal().HistoryValidationContainer(goal,index))
                )],
            ),
            Padding(padding: EdgeInsets.only(top:2,bottom: 1,left: 10),
              child: Text('Note: ${goal.history[index]['note']}'),)

          ],
        ),
      );
    }




  }



