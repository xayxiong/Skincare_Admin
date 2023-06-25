import 'package:flutter/foundation.dart';


import '../model/Employee_Model.dart';
import '../model/Orde_Modelr.dart';

class Order_Notifire with ChangeNotifier{
List<Order_Model_upload> Order =[];
List<CartDetailData>Order_detill=[];
Order_Model_upload Curren_Order =Order_Model_upload();
EmployeeData emp_Ooder = EmployeeData();
 Referenc(){
   Order;
   notifyListeners();
 }
Referencdetill(){
  Order_detill;
  notifyListeners();
}
}