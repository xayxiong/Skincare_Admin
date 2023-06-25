// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../notifire/categoryNotifire.dart';
import '../getCategoryData.dart';

UpdateCategory(CategoryNotifire cate) {
  FirebaseFirestore.instance
      .collection('categorys')
      .doc(cate.CurrentCategory!.id)
      .update({'category': '${cate.CurrentCategory!.category}'}).then((value) async{
    await GetCategoryData(cate);
    cate.RefreshCategory();
  });
}
