// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../notifire/supplierNotifire.dart';
import '../getsupplier.dart';


Delete_supp(SupplierNotifire supp) {
  FirebaseFirestore.instance
      .collection('suppliers')
      .doc(supp.CurrentSupplier!.id)
      .delete()
      .then((value) async {
    await GetSupplier(supp);
    supp.RefreshSupplier();
  });
}
