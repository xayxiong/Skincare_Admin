// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:collection';

import 'package:flutter/cupertino.dart';


import '../model/product_Model.dart';
import '../model/purchase_order_Model.dart';
import '../model/supplier_data.dart';

class SupplierNotifire with ChangeNotifier {
  List<String> Suplierid = [];
  String? SuppType;
  int countket = 0;
  List<SupplierData> Supplier = [];
  SupplierData? CurrentSupplier;
  List<CartModelupload> ImportProduct = [];
  CartModelupload? CurrenimportP_id;
  List<product_Model> Product = [];
  num sumtotal = 0;

  UnmodifiableListView<SupplierData> get SuplierList =>
      UnmodifiableListView(Supplier);

  RefreshSupplier() {
    countket;
    CurrenimportP_id;
    sumtotal;
    Product;
    Supplier;
    ImportProduct;
    notifyListeners();
  }

  getCurrentSupplier() {
    CurrentSupplier;
    notifyListeners();
  }

  SelectType(String? v) {
    SuppType = v;
    notifyListeners();
  }
}
