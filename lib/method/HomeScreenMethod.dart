import 'package:flutter/material.dart';


class HomeMethod{
  Color colorValidation(goal){
    if(goal.goalProgress > goal.goalAmount){
      return Colors.redAccent;
    }else{
      return Colors.black;
    }
  }
}