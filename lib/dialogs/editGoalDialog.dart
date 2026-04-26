import 'package:flutter/material.dart';
import 'package:GoSaver/models/goal.dart';
import 'package:provider/provider.dart';
import 'package:GoSaver/providers/GoalProvider.dart';
import 'package:GoSaver/providers/selectionProvider.dart';
import 'package:GoSaver/dialogs/currencyDialog.dart';

class EditGoalDialog extends StatefulWidget {
  final Goal goal;
  const EditGoalDialog({super.key,required this.goal});

  @override
  State<EditGoalDialog> createState() => _EditGoalDialogState();
}

class _EditGoalDialogState extends State<EditGoalDialog> {



  @override
  Widget build(BuildContext context) {
    final goal = widget.goal;
    TextEditingController _goalName = TextEditingController(text: goal.goalName);
    TextEditingController _goalAmount = TextEditingController(text: '${goal.goalAmount}');
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: EdgeInsets.all(8),
              child: TextField(
                controller: _goalName,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  labelText: 'Goal Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(8),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _goalAmount,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  labelText: 'Goal Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(2),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14)),
                    suffixIcon: Padding(padding: EdgeInsets.all(2),
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.grey[300]
                        ),
                        child:TextButton(onPressed: (){
                          showDialog(context: context,
                              builder: (_) => CurrencyDialog());
                        }, child: Text('${selectedCurrency}',
                          style: TextStyle(color: Colors.blue),
                        ),
                        ),
                      ),
                    ),
                    hintText: 'Currency:',
                    hintStyle: TextStyle(color: Colors.blueAccent),

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
                      .UpdateGoal(goal,_goalName.text,int.parse(_goalAmount.text),selectedCurrency);
                  Navigator.pop(context);
                },
                  child: Text('Done',
                      style: TextStyle(color: Colors.green)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green[50]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}