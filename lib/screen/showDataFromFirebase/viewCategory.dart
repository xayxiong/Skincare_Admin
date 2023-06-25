// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, prefer_adjacent_string_concatenation



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../WidgetSearch/widgetSearch.dart';
import '../../api/getCategoryData.dart';
import '../../celement/elements.dart';
import '../../dialog_edit/dialog_and_snackbar.dart';
import '../../notifire/categoryNotifire.dart';
import '../detialOfdata/categoryDetail.dart';
import '../product_add/category.dart';

class ViewCategory extends StatefulWidget {
  const ViewCategory({Key? key}) : super(key: key);

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future dos() async {
    CategoryNotifire category =
    Provider.of<CategoryNotifire>(context, listen: false);
    await GetCategoryData(category);
    category.RefreshCategory();
  }

  @override
  Widget build(BuildContext context) {
    CategoryNotifire category = Provider.of<CategoryNotifire>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: element.pink,
        centerTitle: true,
        title: const Text(
          'ຂໍ້ມູນປະເພດສິນຄ້າ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: WidgetSearch(label: "ຄົ້ນຫາຂໍ້ມູນປະເພດສິນຄ້າ",notifire: category,type: 'cate'),
        leading: element().RoutePageBack(context, const ProductTypeTapbar()),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: dos,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return CardCategory(index, category);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.black,
              );
            },
            itemCount: category.categoryList.length),
      ),
    );
  }

  Widget CardCategory(int index, CategoryNotifire category) {
    return Card(
        color: Colors.white,
        borderOnForeground: true,
        elevation: 5,
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.category),
                    title: Text(
                        "ຊື່ປະເພດສິນຄ້າ: ${category.categoryList[index].category}",
                        style: const TextStyle(color: Colors.indigo)),
                    subtitle: Text(
                      "ລະຫັດ: ${category.categoryList[index].id}",
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        category.CurrentCategory = category.categoryList[index];
                        Dialog_D(context, name: category.categoryList[index].category,notifire: category ,typefuction: 'cate');
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          onTap: () {
            Text(
              "${category.categoryList[index].category}",
              style: const TextStyle(color: Colors.green),
            );
            category.CurrentCategory = category.categoryList[index];
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const CategoryDetail()));
          },
        ));
  }
}
