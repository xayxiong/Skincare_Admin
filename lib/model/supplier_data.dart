import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierData {
  String? id;
  String? name;
  String? email;
  String? tel;
  String? address;
  String? supplyProduct;
  Timestamp? date;

  SupplierData();
  SupplierData.fromMap(Map<String,dynamic>value){

    this.id = value['id'];
    this.name = value['name'];
    this.email = value['email'];
    this.tel= value['tel'];
    this.address = value['address'];
    this.supplyProduct = value['supplyProduct'];
    this.date= value['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'tel': tel,
      'address': address,
      'supplyProduct': supplyProduct,
      'date':Timestamp.now()
    };
  }
}