import 'package:flutter/material.dart';
import 'package:myfirstapp/dialogs/editGoalDialog.dart';
import 'package:myfirstapp/providers/selectionProvider.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';
import 'package:myfirstapp/models/goal.dart';
import 'package:myfirstapp/models/currency.dart';

class ArchivedLongPressedDialog extends StatefulWidget {
  final Goal archive;
  const ArchivedLongPressedDialog({super.key,required this.archive});

  @override
  State<ArchivedLongPressedDialog> createState() => _ArchivedLongPressedDialogState();
}
class _ArchivedLongPressedDialogState extends State<ArchivedLongPressedDialog> {

  @override
  Widget build(BuildContext context) {
    final goalProvider = context.watch<GoalProvider>();
    final archived = context.watch<GoalProvider>().archived;
    return AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
          child: Text("${widget.archive.goalName}",
            style: TextStyle(),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child:TextButton(onPressed:(){
                goalProvider.UnArchiveGoal(widget.archive);
                Navigator.pop(context);
              }, child: Text('Unarchive',
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
                goalProvider.removeArchive(widget.archive);
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