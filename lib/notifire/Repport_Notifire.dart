import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/Report_Income_Modle.dart';

class report_incomeNotifire with ChangeNotifier{
  List<Report>icome = [];
  List<Report>icome_day = [];
  Report? curren_income;
  int Sumtotal = 0 ;

  List<Report>expanese = [];
  List<Report>expanese_day = [];
  Report? curren_expanese;

  Refresh(){
    Sumtotal;
    expanese;
    expanese_day;
    curren_expanese;
    icome_day;
    curren_income;
    icome;
    notifyListeners();
  }

}