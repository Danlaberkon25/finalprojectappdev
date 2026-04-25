import 'package:flutter/material.dart';
import 'package:myfirstapp/dialogs/editGoalDialog.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';
import 'package:myfirstapp/models/goal.dart';

class Longpresseddialog extends StatefulWidget {
  final Goal goal;
  const Longpresseddialog({super.key,required this.goal});

  @override
  State<Longpresseddialog> createState() => _LongPressedDialogState();
}
class _LongPressedDialogState extends State<Longpresseddialog> {

  @override
  Widget build(BuildContext context) {
    final goalprovider = context.watch<GoalProvider>();
    final goal = widget.goal;
    return AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
          child: Text("${goal.goalName}",
            style: TextStyle(fontSize: 18,color: Colors.blueAccent),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child:TextButton(onPressed:(){
                Navigator.pop(context);
                showDialog(context: context, builder: (_) => EditGoalDialog(goal:goal));
              }, child: Text('Edit',
                style: TextStyle(color: Colors.white),),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    fixedSize: Size(200, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child:TextButton(onPressed:(){
                goalprovider.ArchiveGoal(goal);
                Navigator.pop(context);
              }, child: Text('Archive',
                style: TextStyle(color: Colors.white),),
                style: TextButton.styleFrom(
                    fixedSize: Size(200, 40),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child:TextButton(onPressed:(){
                goalprovider.RemoveGoal(goal);
                Navigator.pop(context);
              }, child: Text('Delete',
                style: TextStyle(color: Colors.white),),
                style: TextButton.styleFrom(
                    fixedSize: Size(200, 40),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                ),
              ),
            ),
          ],
        )
    );
  }
}