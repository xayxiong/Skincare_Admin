
import 'dart:collection';


import 'package:flutter/material.dart';


import '../model/product_Model.dart';
import '../model/purchase_order_Model.dart';

class Cartnotifire with ChangeNotifier{
  List<CartDetailData> Carts =[];
  product_Model? Procartcart;
  int amoultoal=0;
  String Cartsupp ='';
  UnmodifiableListView<CartDetailData>get Cartlist => UnmodifiableListView(Carts);


  cecks(){
    amoultoal++;
  Carts.add(CartDetailData(Procartcart, 1));
  notifyListeners();
  }
  remove(index){
     amoultoal -= Carts[index].amout;
     Carts.removeAt(index);
  notifyListeners();
   }
   sum(index){
     amoultoal++;
     Carts[index].amout++;
     notifyListeners();
   }
   dedet(index){
     if( Carts[index].amout >1){
       amoultoal--;
       Carts[index].amout--;

     }

     notifyListeners();

   }
   getCartsupp(v){
    Cartsupp = v;
   }
   Refresh(){
     amoultoal = 0;
     Carts;
    notifyListeners();
   }
}