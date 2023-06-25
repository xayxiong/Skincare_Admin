// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/screen/showDataFromFirebase/viewProduct.dart';

import '../../celement/elements.dart';
import '../../dialog_edit/dialog_product.dart';
import '../../notifire/categoryNotifire.dart';
import '../../notifire/productNotifire.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    ProductNotifire product = Provider.of<ProductNotifire>(context);
    CategoryNotifire cate = Provider.of<CategoryNotifire>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('ລາຍລະອຽດຂອງສິນຄ້າ'),
          centerTitle: true,
          backgroundColor: element.pink,
          leading: element().RoutePageBack(context, const ViewProduct()),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        '${product.CurrentProduct!.image}',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ລະຫັດສິນຄ້າ: ${product.CurrentProduct!.id}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                                'ຊື່ສິນຄ້າ: ${product.CurrentProduct!.nameProduct}',
                                style: const TextStyle(fontSize: 16)),
                            Text(
                                'ຈຳນວນສິນຄ້າ: ${product.CurrentProduct!.amount} ແພັກ',
                                style: const TextStyle(fontSize: 16)),
                            Text(
                                'ລາຄາຂາຍ: ${product.CurrentProduct!.price} ກີບ',
                                style: const TextStyle(fontSize: 16)),
                            Text(
                                'ລາຍລະອຽດ: ${product.CurrentProduct!.description}',
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 324,
                              height: 50,
                              color: Colors.blue,
                              child: ElevatedButton(
                                onPressed: () {
                                  ProductDialogState().Dialog(
                                      context: context,
                                      product: product,
                                      cate: cate);
                                },
                                child: const Text(
                                  'ແກ້ໄຂ',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ));
  }
}
