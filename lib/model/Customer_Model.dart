// ignore_for_file: equal_keys_in_map

import 'package:cloud_firestore/cloud_firestore.dart';


class CustomerData {
  String? id;
  String? name;
  String? email;
  String? password;
  String? tel;
  String? address;
  String? position;
  String? birthday;
  Timestamp? date;
  CustomerData({
    this.id,
    this.email,
    this.password,
    this.name,
    this.date,
    this.address,
    this.position,
    this.tel,
    this.birthday
  });
  static List<String> positoin = ['Customer'];
  CustomerData.frommap(Map<String, dynamic> value) {
    id = value['id'];
    name = value['name'];
    email = value['email'];
    password = value['password'];
    date = value['date'];
    address = value['address'];
    tel = value['tel'];
    position=value['position'];
    birthday =value['birthday'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'email': email,
      'password': password,
      'date': date,
      'address': address,
      'tel': tel,
     
      'date': Timestamp.now(),
      'birthday':birthday,
    };
  }
}
