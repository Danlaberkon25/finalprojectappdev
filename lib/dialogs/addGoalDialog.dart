import 'package:flutter/material.dart';
import 'package:myfirstapp/models/goal.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';
import 'package:myfirstapp/dialogs/currencyDialog.dart';
import 'package:myfirstapp/providers/selectionProvider.dart';
class AddGoalDialog extends StatefulWidget {
  const AddGoalDialog({super.key});

  @override
  State<AddGoalDialog> createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  TextEditingController _goalName = TextEditingController();
  TextEditingController _goalAmount = TextEditingController();
  TextEditingController _note = TextEditingController();
  String? _currency;

  @override
  Widget build(BuildContext context) {

    final selectedcurrency = context.watch<SelectedCurrencyProvider>().selectedcurrency;
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: const Text("Create New Goal",
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      content: SizedBox(
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Image.asset('assets/waitingGIF.gif',
                height: 49,
                width: 80,),
              ),
              Padding(padding: EdgeInsets.all(5),
                child: TextField(
                  controller: _goalName,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    labelText: 'Goal Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5),
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
            
              Padding(padding: EdgeInsets.all(5),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Padding(padding: EdgeInsets.all(5),
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
                          }, child: Text('${selectedcurrency}',
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
                      style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                  ),
                  ElevatedButton(onPressed: (){

                    if (_goalName.text == '' && _goalAmount.text == ''){
                      _goalName.text = 'Unitlted';
                      _goalAmount.text = '0';
                    }else if(_goalAmount.text == ''){
                      _goalAmount.text = '0';
                    }
                    final goal = Goal(
                      id:DateTime.now()!.toString(),
                      goalName: _goalName.text,
                      goalAmount:int.parse(_goalAmount.text) ?? 0,
                      goalProgress:0,
                      currency:selectedcurrency,
                      goalHistory: [],
                      isArchived: false,
                    );

                    Navigator.pop(context);

                    context.read<GoalProvider>().AddGoal(goal);

                  },
                    child: Text('Add',

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