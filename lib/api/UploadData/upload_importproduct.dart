import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skin_care/notifire/import_product.dart';


Upload_import_product(importproductNotifire importproduct)async{
  CollectionReference reference = await FirebaseFirestore.instance.collection('importproducts');
  reference.add(importproduct.impt_product!.toMap()).then((value){
    FirebaseFirestore.instance.collection('products').doc(importproduct.impt_product!.id_products).update({'amount':FieldValue.increment(importproduct.impt_product!.amout??0)});
  });

}