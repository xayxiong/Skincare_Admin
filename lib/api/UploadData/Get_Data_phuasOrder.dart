import 'dart:async';
import 'dart:math';


import 'package:cloud_firestore/cloud_firestore.dart';


import '../../model/category_Model.dart';
import '../../model/product_Model.dart';
import '../../model/purchase_order_Model.dart';
import '../../notifire/Cartnotififire.dart';
import '../../notifire/purchase_order_Notifire.dart';
import '../../notifire/supplierNotifire.dart';

//  phuas
Upload_Data_phuashOrder(Cartnotifire Cart)async{
  CartModelupload Cartm = CartModelupload();

  Cart.Cartlist.forEach((element)async {
    CartModel m = await CartModel(element.Product!.id,element.amout);
    Cartm.Ditell.add(m.toMap());

  });


  int randomNumber =await Random().nextInt(90) + 1000000;
  Cartm.amouttotal = await Cart.amoultoal;
  Cartm.Supplier_ID = await Cart.Cartsupp;
  Cartm.id = randomNumber.toString();
await FirebaseFirestore.instance.collection('purchase_order').doc(randomNumber.toString()).set(Cartm.toMap());
}

GetPureChaseNoly({required purchase_order_Notifire? order_admin,required SupplierNotifire? supp})async{

  List<CartModelupload> _Sup = [];
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection('purchase_order')
      .where('Supplier_ID', isEqualTo: supp!.CurrentSupplier!.id)
      .get();
  rfn.docs.forEach((element) async{
    CartModelupload Sud = await CartModelupload.formMap(element.data());
    _Sup.add(Sud);
  }
  );
  order_admin!.Order_addmin =_Sup;

  order_admin.Refreshorderaddmin();
}


Future GetDetill({required purchase_order_Notifire order_admin , bool type = true})async{
  int i = 0;
  order_admin.Productditill.clear();
  order_admin.Dettil.clear();
  List<CartModel> _Detilmo =[];
  List<CategoryData> cate= [];
  List<product_Model> prodetill =[];
  if(type = true){
    QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
        .collection('purchase_order')
        .where('date', isEqualTo: order_admin.Currenorderaddmin!.date)
        .get();
    rfn.docs.forEach((element) async{
      List f = await element['Ditell'];
      f.forEach((element) async{
        CartModel m = await CartModel.formMAp(element);
        _Detilmo.add(m);

        QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
            .collection('products')
            .where('id', isEqualTo: m.Product_ID)
            .get();
        rfn.docs.forEach((element)async{
          product_Model f = await  product_Model.formMap(element.data());
          QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
              .collection('categorys')
              .where('id', isEqualTo: f.category_id)
              .get();
          rfn.docs.forEach((element) async{
            CategoryData c = await CategoryData.frommap(element.data());

            for(var h in _Detilmo){
              if(f.id == h.Product_ID){
                f.amount = h.amout;
                prodetill.add(f);
                cate.add(c);
              }
            }

          });
        });



      }
      );
      Future.delayed(Duration(seconds: 1),(){
        order_admin.Productditill = prodetill;
        order_admin.Dettil =_Detilmo;
        order_admin.Product_categoryname = cate;
        order_admin.Refresh();
      });

    });
  }else{
    QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
        .collection('purchase_order')
        .get();
    rfn.docs.forEach((element) async{
      List f = await element['Ditell'];
      f.forEach((element) async{
        CartModel m = await CartModel.formMAp(element);
        _Detilmo.add(m);

        QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
            .collection('products')
            .where('id', isEqualTo: m.Product_ID)
            .get();
        rfn.docs.forEach((element)async{
          product_Model f = await  product_Model.formMap(element.data());
          QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
              .collection('categorys')
              .where('id', isEqualTo: f.category_id)
              .get();
          rfn.docs.forEach((element) async{
            CategoryData c = await CategoryData.frommap(element.data());

            for(var h in _Detilmo){
              if(f.id == h.Product_ID){
                f.amount = h.amout;
                prodetill.add(f);
                cate.add(c);
              }
            }

          });
        });



      }
      );
      Future.delayed(Duration(seconds: 1),(){
        order_admin.Productditill = prodetill;
        order_admin.Dettil =_Detilmo;
        order_admin.Product_categoryname = cate;
        order_admin.Refresh();
      });

    });
  }


}


get_product_purc(SupplierNotifire purcproduct)async{
  purcproduct.Product.clear();
  purcproduct.sumtotal = 0;
  purcproduct.countket =0;
  List<CartModel> _Detilmo =[];
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection('purchase_order')
      .where('id', isEqualTo: purcproduct.CurrenimportP_id!.id)
      .get();
  rfn.docs.forEach((element) async{
    List f = await element['Ditell'];
    f.forEach((element) async{
      CartModel m = await CartModel.formMAp(element);
      _Detilmo.add(m);
      QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
          .collection('products')
          .where('id', isEqualTo: m.Product_ID)
          .get();
      rfn.docs.forEach((element)async{
        product_Model f = await  product_Model.formMap(element.data());
        QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
            .collection('categorys')
            .where('id', isEqualTo: f.category_id)
            .get();
        rfn.docs.forEach((element) async{
          CategoryData c = await CategoryData.frommap(element.data());

          for(var h in _Detilmo){
            if(f.id == h.Product_ID){
              f.amount = h.amout;
              f.category_id  = c.category;
              purcproduct.countket+=h.amout!.toInt();
              purcproduct.Product.add(f);
              purcproduct.RefreshSupplier();
            }
          }

        });
      });



    }
    );
    Future.delayed(Duration(seconds: 1),(){
    purcproduct.RefreshSupplier();
    });

  });
}