import 'dart:collection';

import 'package:flutter/foundation.dart';


import '../model/category_Model.dart';
import '../model/product_Model.dart';
import '../model/purchase_order_Model.dart';

class purchase_order_Notifire with ChangeNotifier{
  List<CartModelupload> Order_addmin =[];
  CartModelupload?Currenorderaddmin;
  product_Model?Productaddmin;
  List<CartModel>Dettil=[];
  List<product_Model> Productditill =[];
  List<CategoryData> Product_categoryname = [];
  UnmodifiableListView<CartModelupload> get Order_addminlist=>UnmodifiableListView(Order_addmin);

  Refreshorderaddmin(){
    Order_addmin;
    Dettil;
    notifyListeners();
  }
  Curren(){

    Currenorderaddmin;
    notifyListeners();
  }
 Refresh(){
   Order_addmin;
   Currenorderaddmin;
   Dettil;
   Product_categoryname;
   Productditill;
   notifyListeners();
 }
}