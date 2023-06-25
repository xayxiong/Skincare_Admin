// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../notifire/employeeNotifire.dart';
import '../getEmployeeData.dart';


Delete_emp(EmployeeNotifire emp) {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(
    email: emp.CurrentEmployee!.email!.trim(),
    password: emp.CurrentEmployee!.password!.trim(),
  )
      .then((value) async {
    await value.user!.delete();
    FirebaseFirestore.instance
        .collection('employees')
        .doc(emp.CurrentEmployee!.id)
        .delete()
        .then((value) {
      emp.RefreshEmp();
    }).then((c) {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emp.CurrentEmployee_loco!.email!.trim(),
        password: emp.CurrentEmployee_loco!.password!.trim(),
      );
      GetEmployeeData(emp);
      emp.RefreshEmp();
    });
  });
}
