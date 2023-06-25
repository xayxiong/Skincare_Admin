// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../notifire/productNotifire.dart';
import '../getProduct.dart';


Delete_products(ProductNotifire pro) {
  FirebaseFirestore.instance
      .collection('products')
      .doc(pro.CurrentProduct!.id)
      .delete()
      .then((value) async {
    FirebaseStorage.instance
        .refFromURL(pro.CurrentProduct!.image.toString())
        .delete();
    await GetProduct(pro);
    pro.RefreshProduct();
  });
}
