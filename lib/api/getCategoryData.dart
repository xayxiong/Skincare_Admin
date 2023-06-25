
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skin_care/model/category_Model.dart';


import '../notifire/categoryNotifire.dart';

GetCategoryData(CategoryNotifire cate) async {
  List<CategoryData> category = [];
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection('categorys')
      .orderBy('category')
      .get();
  cate.cate.clear();
  rfn.docs.forEach((e) {
    print(e.data());
    CategoryData f = CategoryData.frommap(e.data());
    cate.cate.add(e['id']);
    category.add(f);
  });
  cate.category = category;
  cate.RefreshCategory();
}
