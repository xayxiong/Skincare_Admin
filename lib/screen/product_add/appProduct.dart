// ignore_for_file: non_constant_identifier_names





import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/aip.dart';
import '../../api/getCategoryData.dart';
import '../../api/getProduct.dart';
import '../../celement/elements.dart';
import '../../notifire/categoryNotifire.dart';
import '../../notifire/productNotifire.dart';
import '../menu.dart';
import '../showDataFromFirebase/viewProduct.dart';

class ProductAddTapbar extends StatefulWidget {
  const ProductAddTapbar({Key? key}) : super(key: key);

  @override
  State<ProductAddTapbar> createState() => _ProductAddTapbarState();
}

class _ProductAddTapbarState extends State<ProductAddTapbar> {
  @override
  Widget build(BuildContext context) {
    return element().TabbarPage(
        label1: 'ເພີ່ມສິນຄ້າ',
        icos1: Icons.ad_units,
        icos2: Icons.feed,
        label2: 'ລາຍການສິນຄ້າ',
        tap1: const AddProduct(),
        tap2: const ViewProduct());
  }
}

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> Key = GlobalKey<FormState>();
  element elements = element();
  double area = 55;

  @override
  void initState() {
    super.initState();
    dos();
    Productfacing();
  }

  Future dos() async {
    ProductNotifire Pro = Provider.of<ProductNotifire>(context, listen: false);
    await GetProduct(Pro);
  }

  Future Productfacing() async {
    CategoryNotifire category =
        Provider.of<CategoryNotifire>(context, listen: false);
    await GetCategoryData(category);
  }

  @override
  Widget build(BuildContext context) {
    CategoryNotifire category = Provider.of<CategoryNotifire>(context);
    ProductNotifire product = Provider.of<ProductNotifire>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ຂໍ້ມູນສິນຄ້າ'),
        centerTitle: true,
        backgroundColor: element.pink,
        leading: element().RoutePageBack(context, const Menu()),
      ),
      body: SingleChildScrollView(
        child: buildColumn(context, category, product),
      ),
    );
  }

  Column buildColumn(BuildContext context, CategoryNotifire cate, product) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 32,
        ),
        Center(
          child: GestureDetector(
            onTap: () async {
              await AddImage(product);
              area = 100;
            },
            child: CircleAvatar(
              radius: area,
              backgroundColor: element.pink,
              child: product.images != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(product.images!.path),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 102,
                      height: 102,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                          Text('ຮູບພາບ',
                              style: TextStyle(
                                color: Colors.grey[800],
                              )),
                        ],
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Form(
          key: Key,
          child: Column(
            children: [
              elements.inputFields(
                context: context,
                trye: 'nameProduct',
                hint: 'ຊື່ສິນຄ້າ',
                icons: Icons.production_quantity_limits,
                Keybordtye: TextInputType.text,
              ),
              const SizedBox(height: 10),
              elements.inputFields(
                context: context,
                hint: 'ລາຄາ',
                icons: Icons.price_check,
                Keybordtye: TextInputType.number,
                trye: 'price',
              ),
              const SizedBox(height: 10),
              elements.inputFields(
                context: context,
                hint: 'ລາຍລະອຽດ',
                icons: Icons.edit,
                Keybordtye: TextInputType.text,
                trye: 'description',
              ),
              const SizedBox(height: 10),
              elements.inputFields(
                context: context,
                hint: 'ຈຳນວນ',
                icons: Icons.qr_code,
                Keybordtye: TextInputType.number,
                trye: 'amount',
              ),
              const SizedBox(height: 10),
              comboboxcontainer(context, cate),
              const SizedBox(height: 20),
              elements.elevatedButton(Key, 'addproduct', product: product,context: context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

Container comboboxcontainer(context, CategoryNotifire cate) {
  return Container(
      height: 60,
      margin: const EdgeInsets.only(right: 15, left: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 24),
            child: dropdownButton(cate),
          )
        ],
      ));
}

DropdownButton<String> dropdownButton(
  CategoryNotifire cate,
) {
  int index = 0;
  return DropdownButton(
      icon: const Icon(
        Icons.keyboard_arrow_down,
        size: 35,
      ),
      borderRadius: BorderRadius.circular(10),
      value: cate.categoryType,
      isExpanded: true,
      underline: Container(),
      hint: const Padding(
        padding: EdgeInsets.only(left: 50),
        child: Text("ເລືອກປະເພດສິນຄ້າ"),
      ),
      // icon: const Icon(Icons.keyboard_arrow_down),

      items: cate.cate
          .map((e) => DropdownMenuItem(
              value: e,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('${cate.categoryList[index++].category}'),
              )))
          .toList(),
      onChanged: (String? v) {
        cate.SelectType(v);
        element().elementgetcategory(v!);
      });
}
