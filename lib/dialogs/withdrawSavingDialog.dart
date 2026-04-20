import 'package:flutter/material.dart';
import 'package:myfirstapp/models/goal.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';

class withdrawSavingDialog extends StatefulWidget {
  final int index;
  const withdrawSavingDialog({super.key,required this.index});

  @override
  State<withdrawSavingDialog> createState() => _withdrawSavingDialogState();
}

class _withdrawSavingDialogState extends State<withdrawSavingDialog> {
  TextEditingController _goalAmount = TextEditingController();
  TextEditingController _note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: const Text("Withdraw Savings",
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
                    style: TextStyle(color: Colors.red[400])),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink[100]),
                ),
                ElevatedButton(onPressed: (){

                  Provider.of<GoalProvider>(context,listen: false)
                      .WithdrawSavings(widget.index,int.parse(_goalAmount.text),'withdraw',_note.text);

                  Navigator.pop(context);

                },
                  child: Text('Withdraw',

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