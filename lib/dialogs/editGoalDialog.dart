import 'package:flutter/material.dart';
import 'package:myfirstapp/models/goal.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';
import 'package:myfirstapp/providers/selectionProvider.dart';
import 'package:myfirstapp/dialogs/currencyDialog.dart';

class EditGoalDialog extends StatefulWidget {
  final int index;
  const EditGoalDialog({super.key,required this.index});

  @override
  State<EditGoalDialog> createState() => _EditGoalDialogState();
}

class _EditGoalDialogState extends State<EditGoalDialog> {



  @override
  Widget build(BuildContext context) {
    final goal = context.watch<GoalProvider>().goals[widget.index];
    TextEditingController _goalName = TextEditingController(text: goal.goalName);
    TextEditingController _goalAmount = TextEditingController(text: '${goal.goalAmount}');
    TextEditingController _note = TextEditingController(text: '${goal.note}');
    final selectedCurrency = context.watch<SelectedCurrencyProvider>().selectedcurrency;
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: const Text("Edit Goal",
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      content: SizedBox(
        width: 290,
        height: 368,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Image.asset('assets/waitingGIF.gif',
              height: 49,
              width: 80,),
            ),
            Padding(padding: EdgeInsets.all(2),
              child: TextField(
                controller: _goalName,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  labelText: 'Goal Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(2),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _goalAmount,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  labelText: 'Goal Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(2),
              child: TextField(
                controller: _note,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  labelText: 'Note',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(2),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    suffixIcon: Padding(padding: EdgeInsets.all(2),
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blueAccent
                        ),
                        child:TextButton(onPressed: (){
                          showDialog(context: context,
                              builder: (_) => CurrencyDialog());
                        }, child: Text('${selectedCurrency}',
                          style: TextStyle(color: Colors.white),
                        ),
                        ),
                      ),
                    ),
                    hintText: 'Currency:',
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    border: OutlineInputBorder()
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel',
                    style: TextStyle(color: Colors.red[400])),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink[100]),
                ),
                ElevatedButton(onPressed: (){
                  Provider.of<GoalProvider>(context,listen: false)
                      .UpdateGoal(widget.index,_goalName.text,int.parse(_goalAmount.text),_note.text,selectedCurrency);
                  Navigator.pop(context);
                },
                  child: Text('Done',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}