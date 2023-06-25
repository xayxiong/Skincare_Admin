import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../WidgetSearch/widgetSearch.dart';
import '../../celement/elements.dart';
import '../../dialog_edit/dialog_and_snackbar.dart';
import '../../notifire/productNotifire.dart';
import '../detialOfdata/productDetail.dart';
import '../product_add/appProduct.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({Key? key}) : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    ProductNotifire product = Provider.of<ProductNotifire>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: element.pink,
        centerTitle: true,
        title: const Text(
          'ລາຍການສິນຄ້າ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: WidgetSearch(
            label: "ຄົ້ນຫາຂໍ້ມູນລາຍການສິນຄ້າ",
            notifire: product,
            type: 'product'),
        leading: element().RoutePageBack(context, const ProductAddTapbar()),
      ),
      body: ListView.builder(
          itemCount: product.Products.length,
          itemBuilder: (context, index) {
            return Container(
              height: 110,
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  product.CurrentProduct = product.Products[index];
                  product.getCurrentProduct();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductDetail(),
                    ),
                  );
                },
                child: Container(
                  child: Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.network(
                              '${product.Products[index].image ?? element.nullimage}',
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                            Expanded(
                              child: ListTile(
                                title: Row(
                                  children: [
                                    const Text(
                                      'ຊື່ສິນຄ້າ:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      ' ${product.Products[index].nameProduct}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                subtitle: Column(children: [
                                  Text(
                                      'ຈຳນວນສິນຄ້າ:  ${product.Products[index].amount}  ອັນ'),
                                  Text(
                                      'ລາຄາ:  ${NumberFormat.decimalPattern().format(product.Products[index].price)} ກີບ'),
                                ]),
                                trailing: IconButton(
                                  onPressed: () {
                                    product.CurrentProduct =
                                        product.Products[index];
                                    Dialog_D(context,
                                        name:
                                            product.CurrentProduct!.nameProduct,
                                        notifire: product,
                                        typefuction: 'products');
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
