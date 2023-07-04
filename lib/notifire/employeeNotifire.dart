// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../model/Employee_Model.dart';

class EmployeeNotifire with ChangeNotifier {
  
  int addminCount = 0;
  List<EmployeeData> employee = [];
  EmployeeData? CurrentEmployee;
  EmployeeData? CurrentEmployee_loco;
  UnmodifiableListView<EmployeeData> get employeeList =>
      UnmodifiableListView(employee);
  RefreshEmp() {
    employee;
    CurrentEmployee_loco;
    notifyListeners();
  }

  getCurrentEmployee() {
    CurrentEmployee;

    print(CurrentEmployee?.name);
    notifyListeners();
  }

  CheckPosition(String position, EmployeeNotifire emp) {
    if (emp.employeeList.length !=  addminCount) {
      if (position == 'Addmin') {
        addminCount++;
        notifyListeners();
      } 
    }
  }
  ceck(){
    addminCount++;
    notifyListeners();
   
  }
}
