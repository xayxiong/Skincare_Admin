// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/supplier_data.dart';
import '../notifire/supplierNotifire.dart';



GetSupplier(SupplierNotifire supp) async {
  List<SupplierData> _supplier = [];
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection('suppliers')
      .orderBy('email',descending: false)
      .get();
  supp.Suplierid.clear();
  rfn.docs.forEach((e)  {
    SupplierData f =   SupplierData.fromMap(e.data());
    supp.Suplierid.add(e['id']);
    _supplier.add(f);
  });
  supp.Supplier = _supplier;
  supp.RefreshSupplier();
}
