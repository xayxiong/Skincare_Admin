import 'package:cloud_firestore/cloud_firestore.dart';

class product_Model {
  String? id;
  String? nameProduct;
  String? image;
  String? description;
  int? price, amount;
  String? category_id;
  Timestamp? date;

  product_Model();

  product_Model.formMap(Map<String, dynamic> value) {
    id = value['id'];
    nameProduct = value['nameProduct'];
    image = value['image'];
    description = value['description'];
    price = value['price'];
    amount = value['amount'];
    category_id = value['category_id'];
    date = value['date'];

  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameProduct': nameProduct,
      'image': image,
      'description': description,
      'price': price,
      'amount': amount,
      'category_id': category_id,
      'date':DateTime.now()
    };
  }
}
