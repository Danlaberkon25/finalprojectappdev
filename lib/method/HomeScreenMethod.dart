import 'package:flutter/material.dart';


class Homescreenmethod {
  int RemainingStringMethod(goal){
    if (goal.goalRemaining < 0){
      return 0;
    }else{
      return goal.goalRemaining;
    }
  }
}