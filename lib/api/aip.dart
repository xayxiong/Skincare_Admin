// ignore_for_file: non_constant_identifier_names, avoid_print, await_only_futures, unnecessary_brace_in_string_interps, avoid_types_as_parameter_names

import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';

import '../dialog_edit/dialog_and_snackbar.dart';
import '../model/category_Model.dart';
import '../model/product_Model.dart';
import '../model/supplier_data.dart';
import '../notifire/productNotifire.dart';
import '../notifire/supplierNotifire.dart';
import 'getProduct.dart';
import 'getsupplier.dart';

XFile? image;

Future AddImage(ProductNotifire product) async {
  image = await ImagePicker().pickImage(source: ImageSource.gallery);
  product.images = image;
  product.RefreshProduct();
}

Future<void> UploadProducts(
    {ProductNotifire? pro,
    String? nameProduct,
    String? Description,
    int? prices,
    cost,
    amount,
    String? categorys_id}) async {
  product_Model product = product_Model();
  try {
    int random = Random().nextInt(1000);
    Reference ref = await FirebaseStorage.instance
        .ref()
        .child("image/${nameProduct}${random}");
    CollectionReference reference =
        FirebaseFirestore.instance.collection('products');

    final metadata = SettableMetadata(
      contentType: 'image/png',
      customMetadata: {'picked-file-path': image!.path},
    );

    await ref.putFile(io.File(image!.path), metadata);
    String url = await ref.getDownloadURL();
    int id = await Random().nextInt(90)+1000;
    String uid = await '${id.toString()}';
    product.id = await uid;
    product.image = await url;
    product.nameProduct = await nameProduct;
    product.category_id = await categorys_id;
    product.price = await prices;
    product.amount =await  amount;
    product.description =await Description;
   await reference.doc(uid).set(product.toMap())
  .then((value) async {
      image = null;
      await GetProduct(pro!);
      pro.RefreshProduct();
    });
  } catch (e) {
    return print(e.toString());
  }
  print(product.id);
}

String? categorys;

Get_Category_Form(v) {
  categorys = v;
}

AddCategory({required var key}) async {
  CategoryData category = CategoryData();
  try {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('categorys');
    category.category = categorys;
    DocumentReference docid = await reference.add(category.toMap());
    category.id = docid.id;
    docid.set(category.toMap()).then((value) async {
      await ShowMessage(text: 'ປະເພດສິນຄ້າ', type: true);
      key.currentState!.reset();
    });
    print(category.category);
  } catch (e) {
    print(e);
  }
}

AddSupplier(
  SupplierNotifire Supp, {
  required String? name,
  required String? email,
  required String? tel,
  required String? address,
  required String? supplyProduct,
}) async {
  SupplierData supp = SupplierData();
  CollectionReference supplierCollection =
      FirebaseFirestore.instance.collection("suppliers");
  supp.name = name;
  supp.email = email;
  supp.tel = tel;
  supp.address = address;
  supp.supplyProduct = supplyProduct;
  DocumentReference doid = await supplierCollection.add(supp.toMap());
  supp.id = doid.id;
  print(doid.id);
  doid.set(supp.toMap());
  await GetSupplier(Supp);
  Supp.RefreshSupplier();
}
