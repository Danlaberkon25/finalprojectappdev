import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:GoSaver/models/goal.dart';
import 'package:intl/intl.dart';
import 'package:GoSaver/method/GoalScreenMethod.dart';

class GoalProvider with ChangeNotifier {
  final LocalStorage storage;
  List<Goal> _goals = [];
  List<Goal> _archived = [];

  List<Goal> get goals => _goals;
  List<Goal> get archived => _archived;

  GoalProvider(this.storage){
    _loadGoalFromStorage();
    _loadArchivedFromStorage();
  }
  void _loadGoalFromStorage(){
    final goalsStorage = storage.getItem('goals');
    if(goalsStorage != null){
      final List decoded = jsonDecode(goalsStorage);
      _goals = decoded.map((goal) => Goal.fromJson(goal)).toList();
      notifyListeners();
    }
  }

  void _loadArchivedFromStorage(){
    final archivedStorage = storage.getItem('archive');
    if(archivedStorage != null){
      final List decoded = jsonDecode(archivedStorage);
      _archived = decoded.map((archived) => Goal.fromJson(archived)).toList();
      notifyListeners();
    }
  }

  void _saveArchivedToStorage() {
    storage.setItem(
        'archive', jsonEncode(_archived.map((e) => e.toJson()).toList()));
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

  void ArchiveGoal(Goal goal) {
    goal.isArchived = true;
    if(goal.isArchived == true){
      print(goal);
      _archived.add(goal);
      _goals.remove(goal);
      _saveGoalToStorage();
      _saveArchivedToStorage();
      notifyListeners();
    }
  }

  void UnArchiveGoal(archive){
    archive.isArchived = false;
    if(archive.isArchived == false){
      _goals.add(archive);
      _archived.remove(archive);
      _saveArchivedToStorage();
      notifyListeners();
    }
  }

  void RemoveGoal(goal){
    _goals.remove(goal);
    _saveGoalToStorage();
    notifyListeners();
  }

  void removeArchive(archive){
    _archived.remove(archive);
    _saveArchivedToStorage();
    notifyListeners();
  }


  void AddSavings(goal, int amount,String operator,note) {
    final dateFormat = DateFormat.yMMMMd('en_US').add_jm().format(DateTime.now());
    goal.goalProgress += amount;
    goal.goalHistory.add({
      'date': dateFormat,
      'amount': amount.toString(),
      'operator':'add',
      'note':note,
    });

    _saveGoalToStorage();
    notifyListeners();
  }

  void WithdrawSavings(goal,int amount,String operator,note){
      goal.goalProgress -= amount;
      final dateFormat = DateFormat.yMMMMd('en_US').add_jm().format(DateTime.now());
      goal.goalHistory.add({
        'date': dateFormat,
        'amount': amount.toString(),
        'operator':'withdraw',
        'note':note,
      });
      _saveGoalToStorage();
      notifyListeners();



  }

  void UpdateGoal(goal,String name,int amount,String currency){
      goal.goalName = name;
      goal.goalAmount = amount;
      goal.currency = currency;
      _saveGoalToStorage();
      notifyListeners();
  }


}
