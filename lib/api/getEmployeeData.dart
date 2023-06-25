// ignore_for_file: avoid_function_literals_in_foreach_calls, non_constant_identifier_names, unused_local_variable, avoid_print, file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/Employee_Model.dart';
import '../notifire/employeeNotifire.dart';
import '../screen/login.dart';
import '../screen/menu.dart';

GetEmployeeData(EmployeeNotifire emp) async {
  List<EmployeeData> employee = [];
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection('employees')
      .orderBy('position')
      .get();
  rfn.docs.forEach(
    (e) {
      print(e.data());
      EmployeeData f = EmployeeData.frommap(e.data());
      employee.add(f);
    },
  );
  emp.employee = employee;
  emp.RefreshEmp();
}

GetEmployeeData_only(
    EmployeeNotifire emp, String email, BuildContext context) async {
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection('employees')
      .where('email', isEqualTo: '${email}')
      .get();
  rfn.docs.forEach(
    (e) async {
      EmployeeData em = await EmployeeData.frommap(e.data());
      emp.CurrentEmployee_loco = em;
      if (emp.CurrentEmployee_loco!.position == 'Addmin') {
        formKey.currentState!.reset();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Menu(),
          ),
        );
      } else if (emp.CurrentEmployee_loco!.position == 'Sale') {
        Fluttertoast.showToast(
          msg: "ທ່ານບໍ່ເເມ່ນ Addmin",
          fontSize: 20,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    },
  );

  emp.RefreshEmp();
}
