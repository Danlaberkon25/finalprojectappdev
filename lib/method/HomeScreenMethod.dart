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

  Color conditionColorSaved(goal){
    if (goal.goalProgress > goal.goalAmount){
      return Colors.redAccent;
    }else if(goal.goalProgress == goal.goalAmount){
      return Colors.green;

    }else{
      return Colors.black;
    }
  }


  /// Getting Percentage of the goal to display on the progress bar
  double gettingPercentage(goal) {
    final getPercentage = (goal.goalProgress / goal.goalAmount) * 100;
    if(goal.goalAmount != 0){
      if(getPercentage > 100){
        return 100;
      }else{
        return getPercentage;
      }
    }else{
      return 0;

    }

  }

  /// getting 
  double getPercentage(goal) {
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



}