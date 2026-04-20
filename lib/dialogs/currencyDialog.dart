import 'package:flutter/material.dart';
import 'package:myfirstapp/providers/selectionProvider.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';
import 'package:myfirstapp/models/goal.dart';
import 'package:myfirstapp/models/currency.dart';

class CurrencyDialog extends StatefulWidget {
  const CurrencyDialog({super.key});

  @override
  State<CurrencyDialog> createState() => _CurrencyDialogState();
}
typedef currency = DropdownMenuEntry<String>;
class _CurrencyDialogState extends State<CurrencyDialog> {
  String? _selectedCurrency;
  TextEditingController _selectedCurrencyText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: const Text("Set Your Currency",
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      content: SizedBox(
        width: 280,
        height: 276,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Image.asset('assets/milkandmocha.gif',
              height: 59,
              width: 80,),
            ),
            Padding(padding: EdgeInsets.all(3),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                hintText: '₱',
                hintStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(),
              ),
                items: [
                  DropdownMenuItem(value: '₱',child: Text('₱'),),
                  DropdownMenuItem(value: '﹩',child: Text('﹩'),),
                  DropdownMenuItem(value: '¥',child: Text('¥'),),
                  DropdownMenuItem(value: '₤',child: Text('₤'),),
                ],
                value: _selectedCurrency,
                onChanged: (val){
                setState(() {
                  _selectedCurrency = val!;
                });
                }
            ),
            ),
            Padding(padding: EdgeInsets.all(3),
            child: Center(
              child: Text('or',
              style: TextStyle(fontSize: 20),
              ),
            ),
            ),
            Padding(padding: EdgeInsets.all(3),
            child: TextField(
              controller: _selectedCurrencyText,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Type your currency',
                labelStyle: TextStyle(color: Colors.blueAccent)
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
                  if(_selectedCurrencyText.text.isNotEmpty){
                    context.read<SelectedCurrencyProvider>().setSelected(_selectedCurrencyText.text);
                  }else if(_selectedCurrencyText.text.isEmpty){
                    context.read<SelectedCurrencyProvider>().setSelected(_selectedCurrency!);
                  }
                  Navigator.pop(context);
                }, child: Text('Add',
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