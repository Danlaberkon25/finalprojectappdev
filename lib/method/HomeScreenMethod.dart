import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Homescreenmethod {
  int RemainingStringMethod(goal){
    if (goal.goalRemaining < 0){
      return 0;
    }else{
      return goal.goalRemaining;
    }
  }

  Widget ExcessSaved(goal){
    final formatter = NumberFormat('#,##0.00');
    if (goal.goalProgress > goal.goalAmount){
      return Text('${goal.currency} ${formatter.format(goal.goalProgress)}',
      style: TextStyle(color: Colors.redAccent),
        overflow: TextOverflow.ellipsis,);
    }else{
      return Text('${goal.currency} ${formatter.format(goal.goalProgress)}',
        style: TextStyle(color: Colors.black),
        overflow: TextOverflow.ellipsis,);
    }
  }

  double gettingPercentage(goal) {
    final getPercentage = (goal.goalProgress / goal.goalAmount) * 100;
    if(goal.goalAmount != 0){
      return getPercentage;
    }else{
      return 0;

    }

  }



}