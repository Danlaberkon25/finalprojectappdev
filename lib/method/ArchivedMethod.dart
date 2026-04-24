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
}