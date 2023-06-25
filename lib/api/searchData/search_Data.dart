// ignore_for_file: unused_local_variable, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/Employee_Model.dart';
import '../../model/category_Model.dart';
import '../../model/product_Model.dart';
import '../../model/supplier_data.dart';
import '../../notifire/categoryNotifire.dart';
import '../../notifire/employeeNotifire.dart';
import '../../notifire/productNotifire.dart';
import '../../notifire/supplierNotifire.dart';

Future SearchProduct(ProductNotifire pro,String values) async {
  List<product_Model>? _Product = [];
  List<product_Model> _f = [];
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection('products')
      .where('nameProduct', isGreaterThanOrEqualTo: '${values}')
      .get();
  pro.Product.clear();
  rfn.docs.forEach((data) async {
    String nameProduct = data['nameProduct'].toString();
    if (nameProduct.trim() == values) {
      product_Model p = await product_Model.formMap(data.data());
      _f.add(p);
      pro.RefreshProduct();
    } else if (nameProduct[0] == values[0] && nameProduct[1] == values[1] || nameProduct[0] == values[0] || nameProduct[0] == [1]) {
      product_Model p = await product_Model.formMap(data.data());
      _Product.add(p);
    }
  });
  waitt(pro, _f, _Product);
}

Future waitt(ProductNotifire pro, _f, _Product) async {
  Future.delayed(Duration(seconds: 1), () {
    if (_f.length != 0) {
      print(_f.length);
      pro.Product = _f;
      pro.RefreshProduct();
    } else {
      pro.Product.clear();
      print(_Product.length);
      pro.Product = _Product;
      pro.RefreshProduct();
    }
  }).catchError((err) {});
}



Future Searchcategory(CategoryNotifire cate,String values) async {
  List<CategoryData>? _cate = [];
  List<CategoryData> _f = [];
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection('categorys')
      .where('category', isGreaterThanOrEqualTo: '${values}')
      .get();
  cate.category.clear();
  rfn.docs.forEach((data) async {
    String namecate = data['category'].toString();
    if (namecate.trim() == values) {
      CategoryData p = await CategoryData.frommap(data.data());
      _f.add(p);
      cate.RefreshCategory();
    } else if (namecate[0] == values[0] && namecate[1] == values[1] || namecate[0] == values[0] || namecate[0] == [1]) {
      CategoryData p = await CategoryData.frommap(data.data());
      _f.add(p);
    }
  });
  Future.delayed(Duration(seconds: 1), () {
    if (_f.length != 0) {
      print(_f.length);
      cate.category = _f;
      cate.RefreshCategory();
    } else {
      cate.category.clear();
      print(_cate.length);
      cate.category = _cate;
      cate.RefreshCategory();
    }
  }).catchError((err) {});
}



Future Searchemp(EmployeeNotifire emp,String values) async {
  List<EmployeeData>? _emp = [];
  List<EmployeeData> _f = [];
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection('employees')
      .where('name', isGreaterThanOrEqualTo: '${values}')
      .get();
  emp.employee.clear();
  rfn.docs.forEach((data) async {
    String namecate = data['name'].toString();
    if (namecate.trim() == values) {
      EmployeeData p = await EmployeeData.frommap(data.data());
      _f.add(p);
      emp.RefreshEmp();
    } else if (namecate[0] == values[0] && namecate[1] == values[1] || namecate[2] == values[2] || namecate[0] == [1]) {
      EmployeeData p = await EmployeeData.frommap(data.data());
      _f.add(p);
    }
  });
  Future.delayed(Duration(seconds: 1), () {
    if (_f.length != 0) {
      print(_f.length);
      emp.employee = _f;
      emp.RefreshEmp();
    } else {
      emp.employee.clear();
      print(_emp.length);
      emp.employee = _emp;
      emp.RefreshEmp();
    }
  }).catchError((err) {});
}


Future Searchsupp(SupplierNotifire supp,String values) async {
  List<SupplierData> _supp = [];
  List<SupplierData> _f = [];
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection('suppliers')
      .where('name', isGreaterThanOrEqualTo: '${values}')
      .get();
  supp.Supplier.clear();
  rfn.docs.forEach((data) async {
    String namecate = data['name'].toString();
    if (namecate.trim() == values) {
      SupplierData p = await SupplierData.fromMap(data.data());
      _f.add(p);
      supp.RefreshSupplier();
    } else if (namecate[0] == values[0] && namecate[1] == values[1] || namecate[0] == values[0] || namecate[0] == [1]) {
      SupplierData p = await SupplierData.fromMap(data.data());
      _f.add(p);
    }
  });
  Future.delayed(Duration(seconds: 1), () {
    if (_f.length != 0) {
      print(_f.length);
      supp.Supplier = _f;
      supp.RefreshSupplier();
    } else {
      supp.Supplier.clear();
      print(_supp.length);
      supp.Supplier = _supp;
      supp.RefreshSupplier();
    }
  }).catchError((err) {});
}
