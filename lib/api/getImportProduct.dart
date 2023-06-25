import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skin_care/model/importproducts_Model.dart';
import 'package:skin_care/model/product_Model.dart';


import '../model/purchase_order_Model.dart';
import '../model/supplier_data.dart';
import '../notifire/supplierNotifire.dart';

getImPortProduct(SupplierNotifire importProduct) async {
  importProduct.Product.clear();
  importProduct.sumtotal = 0;
  importProduct.countket =0;
  importProduct.Supplier.clear();
  importProduct.ImportProduct.clear();
  QuerySnapshot<Map<String, dynamic>> rfn =
  await FirebaseFirestore.instance.collection('purchase_order').orderBy('date',descending: true).get();
  rfn.docs.forEach((element) async {
    print(element.data().length);

    CartModelupload cartModelupload = CartModelupload.formMap(element.data());
    importProduct.ImportProduct.add(cartModelupload);
    QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
        .collection('suppliers')
        .where('id', isEqualTo: cartModelupload.Supplier_ID)
        .get();
    rfn.docs.forEach((element) async {
      SupplierData supplier = SupplierData.fromMap(element.data());
      importProduct.Supplier.add(supplier);
      importProduct.RefreshSupplier();
    });
  });
}

get_Detail_ImPortProduct(SupplierNotifire importProduct) async {
importProduct.sumtotal = 0;
importProduct.countket = 0;
importProduct.Product.clear();

FirebaseFirestore rfn = FirebaseFirestore.instance;
QuerySnapshot<Map<String,dynamic>> imp = await  rfn.collection('importproducts').where('id_purchase',isEqualTo: importProduct.CurrenimportP_id!.id).get();
  imp.docs.forEach((element) async{
    import_products imp = await import_products.formMap(element.data());
    print(imp.id_purchase.toString() +' di_p' );
    print(importProduct.CurrenimportP_id!.id.toString() + ' hhhh');
       importProduct.sumtotal+=imp.sumtotal!.toInt();
       importProduct.countket+=imp.amout!.toInt();
       QuerySnapshot<Map<String,dynamic>> productimport  =  await rfn.collection('products').where('id',isEqualTo: imp.id_products).get();
       productimport.docs.forEach((element) async{
         product_Model p = product_Model.formMap(element.data());
                       p.amount = imp.amout!.toInt();
                       p.price =imp.cost!.toInt();
                       p.date = imp.date;
         QuerySnapshot<Map<String,dynamic>> cate = await rfn.collection('categorys').where('id',isEqualTo:  p.category_id).get();
         cate.docs.forEach((element) {
                  print( element['category']);
                        p.category_id = element['category'];
                        importProduct.Product.add(p);

                        importProduct.RefreshSupplier();
                  print(p.nameProduct.toString() + p.category_id.toString());
         });
       });
  });
}