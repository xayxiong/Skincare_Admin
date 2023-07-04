// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:skin_care/model/Customer_Model.dart';


class CustomerNotifire with ChangeNotifier {
  int customerCount = 0;
 
  List<CustomerData> customer = [];
  CustomerData? CurrentCustomer;
  CustomerData? CurrentCustomer_loco;
  UnmodifiableListView<CustomerData> get customerList =>
      UnmodifiableListView(customer);
  RefreshCtm() {
    customer;
    CurrentCustomer_loco;
    notifyListeners();
  }

  getCurrentCustomer() {
    CurrentCustomer;

    print(CurrentCustomer?.name);
    notifyListeners();
  }

  CheckPosition(String position, CustomerNotifire ctm) {
    if (ctm.customerList.length != customerCount) {
      if (position == 'Customer') {
        customerCount++;
        notifyListeners();
      } 
    }
  }
  ceck(){
    customerCount++;
    notifyListeners();
   
  }
}
