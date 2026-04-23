import 'package:myfirstapp/screens/goalScreen.dart';
import 'package:flutter/material.dart';
class MethodEditGoal{
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

  Color colorValidation(goal){
    if(goal.goalProgress > goal.goalAmount){
      return Colors.redAccent;
    }else{
      return Colors.black;
    }
  }

  Color colorValidation2(String operator){
    if(operator == 'withdraw'){
      return Colors.redAccent;
    }else{
      return Colors.green;
    }
  }


}