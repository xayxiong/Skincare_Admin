



import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:skin_care/model/Employee_Model.dart';

import 'package:skin_care/model/Orde_Modelr.dart';

import '../model/product_Model.dart';
import '../notifire/OrderNotifire.dart';


Get_Order({required Order_Notifire Order , String type =''})async{
   Order.Order.clear();
    List<Order_Model_upload>order_model=[];
      if(type == 'Dunt'){
        QuerySnapshot<Map<String , dynamic>> rfn =await FirebaseFirestore.instance.collection('order').where('Staustus',isEqualTo:'ສຳເລັດ' ).get();
        rfn.docs.forEach((element) {order_model.add(Order_Model_upload.formMap(element.data()));
        Order.Order =order_model;
        Order.Referenc();
        });

      }else if( type == 'Wait'){
        QuerySnapshot<Map<String , dynamic>> rfn =await FirebaseFirestore.instance.collection('order').where('Staustus',isEqualTo:'ລໍຖ້າ' ).get();
        rfn.docs.forEach((element) {order_model.add(Order_Model_upload.formMap(element.data()));
        Order.Order =order_model;
        Order.Referenc();
        });

      }else{
        QuerySnapshot<Map<String , dynamic>> rfn =await FirebaseFirestore.instance.collection('order').orderBy('date',descending: true).get();
        rfn.docs.forEach((element) {order_model.add(Order_Model_upload.formMap(element.data()));
        Order.Order =order_model;
        Order.Referenc();
        });

      };



  }
  Get_Order_Detlill(Order_Notifire Order)async{

    List<CartDetailData>detill=[];
    Order.Curren_Order.Ditell.forEach((v)async {
      QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
          .collection('employees')
          .where('id', isEqualTo: Order.Curren_Order)
          .get();
      rfn.docs.forEach((element)async {
        EmployeeData emp = EmployeeData.frommap(element.data());
        Order.emp_Ooder =  await emp;
       // Order.Referencdetill();
      });
      });
      Order.Curren_Order.Ditell.forEach((v) async {
        QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore
            .instance
            .collection('products')
            .where('id', isEqualTo: v['product_id'])
            .get();
        rfn.docs.forEach((element) async {
          product_Model f = product_Model.formMap(element.data());
          QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore
              .instance
              .collection('categorys')
              .where('id', isEqualTo: f.category_id)
              .get();
          rfn.docs.forEach((element) async {
            f.category_id = await element['category'];
            detill.add(CartDetailData(f, v['amout'], v['sum']));
            Order.Order_detill = await detill;
           // print(Order.Order_detill.length);
           //
          });
          Order.Referencdetill();
        });
      });
    }