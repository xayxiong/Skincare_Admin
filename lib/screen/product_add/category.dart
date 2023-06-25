// ignore_for_file: non_constant_identifier_names





import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/screen/showDataFromFirebase/viewCategory.dart';

import '../../api/getCategoryData.dart';
import '../../celement/elements.dart';
import '../../notifire/categoryNotifire.dart';
import '../menu.dart';

class ProductTypeTapbar extends StatefulWidget {
  const ProductTypeTapbar({Key? key}) : super(key: key);

  @override
  State<ProductTypeTapbar> createState() => _ProductTypeTapbarState();
}

class _ProductTypeTapbarState extends State<ProductTypeTapbar> {
  @override
  Widget build(BuildContext context) {
    return element().TabbarPage(
        label1: 'ເພີ່ມປະເພດສິນຄ້າ',
        icos1: Icons.ad_units,
        icos2: Icons.feed,
        label2: 'ຂໍ້ມູນປະເພດສິນຄ້າ',
        tap1: const Category(),
        tap2: const ViewCategory());
  }
}

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    super.initState();
    dos();
  }

  Future dos() async {
    CategoryNotifire category = Provider.of<CategoryNotifire>(context, listen: false);
    await GetCategoryData(category);
  }

  GlobalKey<FormState> Key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: element.pink,
        leading: element().RoutePageBack(context, const Menu()),
        title: Text(element.p6),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Form(
              key: Key,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    element().inputFields(
                        icons: Icons.category,
                        hint: ' ປະເພດສິນຄ້າ',
                        Keybordtye: TextInputType.text,
                        trye: 'Products_type',
                        context: context),
                    const SizedBox(height: 20),
                    element().elevatedButton(Key, 'addproduct_type',context: context),
                  ],
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
