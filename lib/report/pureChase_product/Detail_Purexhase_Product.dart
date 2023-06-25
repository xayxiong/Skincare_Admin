import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/report/pureChase_product/purechase_Product.dart';
import 'package:skin_care/report/pureChase_product/reportPurchaseProductToPDF.dart';

import '../../celement/elements.dart';

import '../../notifire/supplierNotifire.dart';

class Detaiy_purcChase_product extends StatefulWidget {
  const Detaiy_purcChase_product({Key? key}) : super(key: key);

  @override
  State<Detaiy_purcChase_product> createState() =>
      _Detaiy_purcChase_productState();
}

class _Detaiy_purcChase_productState extends State<Detaiy_purcChase_product> {
  @override
  Widget build(BuildContext context) {
    SupplierNotifire pro = Provider.of<SupplierNotifire>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ລາຍງານຂໍ້ມູນ ສັ່ງສິນຄ້າເຂົ້າຮ້ານ'),
        centerTitle: true,
        backgroundColor: element.pink,
        leading: element().RoutePageBack(context, const purChase_Product()),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  side: BorderSide(width: 3, color: Colors.teal)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const <Widget>[
                    SizedBox(
                      width: 34,
                      child: Text(
                        'ລຳດັບ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        'ຊື່ສິນຄ້າ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    SizedBox(
                      child: Text(
                        'ຈຳນວນ',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    SizedBox(
                      child: Text(
                        'ປະເພດ',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: pro.Product.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      side: BorderSide(width: 1, color: Colors.indigo)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          width: 34,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(
                            '${pro.Product[index].nameProduct}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          child: Text(
                            '${pro.Product[index].amount}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          child: Text(
                            '${pro.Product[index].category_id}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('ທັ້ງໝົດ: ${pro.Product.length} ລາຍການ',
                      style: TextStyle(fontSize: 17)),
                  Text(' ${pro.countket} ອັນ', style: TextStyle(fontSize: 17)),
                ],
              )),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            width: double.maxFinite,
            height: 55,
            child: ElevatedButton(
                onPressed: () {
                  PurchaseProductPDF.SavePurchaseProductPDF(pro, context);
                },
                child: const Text(
                  'ພິມລາຍງານ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                )),
          ),
          const SizedBox(height: 60)
        ],
      ),
    );
  }
}
