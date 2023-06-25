// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';

class import_products {
  String? id_purchase;
  String? id_products;
  num? amout ;
  num? cost;
  num? sumtotal;
  Timestamp? date;
  import_products({this.amout,this.id_products,this.id_purchase,this.cost,this.sumtotal});
  import_products.formMap(Map<String,dynamic>v){
    id_purchase = v['id_purchase'];
    id_products = v['id_products'];
    cost = v['cost'];
    amout = v['amout'];
    sumtotal =v['sumtotal'];
    date =v['date'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id_purchase': id_purchase,
      'id_products': id_products,
      'cost': cost,
      'amout': amout,
      'sumtotal': sumtotal,
       'date': Timestamp.now()
    };
  }
}
