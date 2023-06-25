import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../notifire/productNotifire.dart';
import '../getProduct.dart';

Update_products(ProductNotifire pro) async {
  if (pro.ChangeImage == null) {
    FirebaseFirestore.instance
        .collection('products')
        .doc(pro.CurrentProduct!.id)
        .update(pro.CurrentProduct!.toMap())
        .then((value) {
      pro.RefreshProduct();
    });
  } else if (pro.ChangeImage != null) {
    final metadata = SettableMetadata(
      contentType: 'image/png',
      customMetadata: {'picked-file-path': pro.ChangeImage!.path},
    );
    Reference ref = await FirebaseStorage.instance
        .ref()
        .child("image/${pro.CurrentProduct!.nameProduct}");
    await ref.putFile(File(pro.ChangeImage!.path), metadata);
    var url = await ref.getDownloadURL();
    pro.CurrentProduct!.image = url;
    await FirebaseFirestore.instance
        .collection('products')
        .doc(pro.CurrentProduct!.id)
        .update(pro.CurrentProduct!.toMap())
        .then((value) async {
      await GetProduct(pro);
      pro.RefreshProduct();
    });
  }
}
