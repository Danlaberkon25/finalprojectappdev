import 'package:myfirstapp/dialogs/currencyDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:convert';



class SelectedCurrencyProvider with ChangeNotifier{
  String _selectedcurrency  = '₱';

  String get selectedcurrency => _selectedcurrency;


  void setSelected(String value){
    _selectedcurrency = value;
    notifyListeners();
  }
}