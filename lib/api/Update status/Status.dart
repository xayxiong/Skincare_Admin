import 'package:cloud_firestore/cloud_firestore.dart';

import '../../notifire/OrderNotifire.dart';
import '../get_Order.dart';


update_Status(Order_Notifire order)async{
  print(order.Curren_Order.id);
 await FirebaseFirestore.instance.collection('order').doc(order.Curren_Order.id).update({'Staustus':'ສຳເລັດ'});
 Get_Order(Order: order);
}