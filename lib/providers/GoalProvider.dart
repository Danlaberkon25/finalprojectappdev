import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:myfirstapp/models/goal.dart';
import 'package:intl/intl.dart';

class GoalProvider with ChangeNotifier {
  final LocalStorage storage;
  List<Goal> _goals = [];

  List<Goal> get goals => _goals;

  GoalProvider(this.storage){
    _loadGoalFromStorage();
  }
  void _loadGoalFromStorage(){
    final goalsStorage = storage.getItem('goals');
    if(goalsStorage != null){
      final List decoded = jsonDecode(goalsStorage);
      _goals = decoded.map((goal) => Goal.fromJson(goal)).toList();
      notifyListeners();
    }
  }

  void _saveGoalToStorage() {
    storage.setItem('goals',jsonEncode(_goals.map((e) => e.toJson()).toList())
    );
  }



  void AddGoal(Goal goal){
    _goals.add(goal);
    _saveGoalToStorage();
    notifyListeners();

  }

  void RemoveGoal(goal){
    _goals.remove(goal);
    _saveGoalToStorage();
    notifyListeners();
  }

  void AddSavings(int index, int amount,String operator,note) {
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());

    _goals[index].goalProgress += amount;
    _goals[index].goalRemaining -= amount;

    _goals[index].history!.add({
      'date': dateFormat,
      'amount': amount.toString(),
      'operator':'add',
      'note':note,
    });

    _saveGoalToStorage();
    notifyListeners();
  }

  void WithdrawSavings(int index,int amount,String operator,note){
    _goals[index].goalProgress -= amount;
    _goals[index].goalRemaining += amount;
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
    _goals[index].history!.add({
      'date': dateFormat,
      'amount': amount.toString(),
      'operator':'withdraw',
      'note':note,
    });
    _saveGoalToStorage();
    notifyListeners();
  }

  void UpdateGoal(int index,String name,int amount,String note,String currency){
    if(_goals[index].goalProgress > _goals[index].goalRemaining){
      _goals[index].goalName = name;
      _goals[index].goalAmount = amount;
      _goals[index].goalRemaining = _goals[index].goalAmount - _goals[index].goalProgress;
      _goals[index].note = note;
      _goals[index].currency = currency;
      _saveGoalToStorage();
      notifyListeners();

    }else{
      _goals[index].goalName = name;
      _goals[index].goalAmount = amount;
      _goals[index].goalRemaining = amount;
      _goals[index].note = note;
      _goals[index].currency = currency;
      _saveGoalToStorage();
      notifyListeners();
    }

  }
}
