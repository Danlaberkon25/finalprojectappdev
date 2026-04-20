import 'package:flutter/material.dart';
import 'package:myfirstapp/providers/selectionProvider.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';
import 'package:myfirstapp/models/goal.dart';
import 'package:myfirstapp/models/currency.dart';

class ConfirmationDialog extends StatefulWidget {
  final Goal goal;
  const ConfirmationDialog({super.key,required this.goal});

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}
class _ConfirmationDialogState extends State<ConfirmationDialog> {

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GoalProvider>();
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: const Text("Delete Goal?",
          style: TextStyle(),
        ),
      ),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Image.asset('assets/mocha-cry.gif',
              height: 59,
              width: 80,),
            ),
            SizedBox(height: 10,),
            Center(
              child:Text("Are you sure you want to Delete?"),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel',
                    style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                ),
                ElevatedButton(onPressed: (){
                  provider.RemoveGoal(widget.goal);
                  Navigator.pop(context);
                }, child: Text('Yes Delete',
                    style: TextStyle(color: Colors.redAccent[400])),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink[100]),
                ),
              ],
            )
          ],
        )
    );
  }
}