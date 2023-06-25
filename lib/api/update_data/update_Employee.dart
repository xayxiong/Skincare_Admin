import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skin_care/notifire/employeeNotifire.dart';

import '../getEmployeeData.dart';


update_Employee(EmployeeNotifire emp,
    {required String email, required String pass}) async {
  var user = await FirebaseAuth.instance;
  print(emp.CurrentEmployee!.email);
  FirebaseAuth.instance
      .signInWithEmailAndPassword(
    email: emp.CurrentEmployee!.email!.trim(),
    password: emp.CurrentEmployee!.password!.trim(),
  )
      .then((value) async {
    await value.user!.updateEmail(email);
    await value.user!.updatePassword(pass);
    emp.CurrentEmployee!.email = email;
    emp.CurrentEmployee!.password = pass;
    FirebaseFirestore.instance
        .collection('employees')
        .doc(emp.CurrentEmployee!.id)
        .update(emp.CurrentEmployee!.toMap())
        .then((value) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emp.CurrentEmployee_loco!.email.toString(),
        password: emp.CurrentEmployee_loco!.password.toString(),
      )
          .then((value) async{
        await GetEmployeeData(emp);
        emp.RefreshEmp();
      });
    });
  });
}
