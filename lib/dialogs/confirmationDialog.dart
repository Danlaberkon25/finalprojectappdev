import 'package:flutter/material.dart';
import 'package:GoSaver/providers/GoalProvider.dart';
import 'package:provider/provider.dart';
import 'package:GoSaver/models/goal.dart';

class ConfirmationDialog extends StatelessWidget{
  final Goal goal;
  const ConfirmationDialog({super.key,required this.goal});
  @override
  Widget build(BuildContext context){
    final provider = context.watch<GoalProvider>();
    return AlertDialog(
      title: Center(
        child: Text('Are you sure?'),
      ),
      content: Row(
        children: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Container(
            width: 90,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text('Cancel',
              style: TextStyle(color: Color(0xFF6B7280)),),
            ),
          )
          ),
          TextButton(onPressed: (){
            provider.RemoveGoal(goal);
            Navigator.pop(context);
          }, child: Container(
            width: 90,
            height: 30,
            decoration: BoxDecoration(
                color: Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text('Confirm',
              style: TextStyle(color: Color(0xFFFFFFFF)),),
            ),
          )
          ),
        ],
      ),
    );
  }
}