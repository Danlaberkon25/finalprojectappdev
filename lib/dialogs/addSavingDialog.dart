import 'package:flutter/material.dart';
import 'package:myfirstapp/models/goal.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';
import 'package:intl/intl.dart';

class AddSavingDialog extends StatefulWidget {
  final Goal goal;
  const AddSavingDialog({super.key,required this.goal});

  @override
  State<AddSavingDialog> createState() => _AddSavingDialogState();
}

class _AddSavingDialogState extends State<AddSavingDialog> {
  TextEditingController _goalAmount = TextEditingController();
  TextEditingController _note = TextEditingController();
  final _add = 'add';



  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: const Text("Add Savings",
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      content: SizedBox(
        width: 280,
        height: 230,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Image.asset('assets/waitingGIF.gif',
              height: 49,
              width: 80,),
            ),
            Padding(padding: EdgeInsets.all(2),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _goalAmount,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  labelText: 'Enter Amount',
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
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel',
                    style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[50]),
                ),
                ElevatedButton(onPressed: (){

                  Provider.of<GoalProvider>(context,listen: false)
                        .AddSavings(widget.goal,int.parse(_goalAmount.text),_add,_note.text);

                  Navigator.pop(context);

                },
                  child: Text('Add',

                      style: TextStyle(color: Colors.green)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[50]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}