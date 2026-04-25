import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Archivedmethod {
  Widget ExcessSaved(archive){
    final formatter = NumberFormat('#,##0.00');
    if (archive.goalProgress > archive.goalAmount){
      return Text('${archive.currency} ${formatter.format(archive.goalProgress)}',
        style: TextStyle(color: Colors.redAccent),
        overflow: TextOverflow.ellipsis,);
    }else{
      return Text('${archive.currency} ${formatter.format(archive.goalProgress)}',
        style: TextStyle(color: Colors.black),
        overflow: TextOverflow.ellipsis,);
    }
  }

  double gettingPercentage(archive) {
    final getPercentage = (archive.goalProgress / archive.goalAmount) * 100;
    if (archive.goalAmount != 0) {
      return getPercentage;
    } else {
      return 0;
    }
  }

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