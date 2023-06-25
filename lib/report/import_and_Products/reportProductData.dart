import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/report/import_and_Products/reportProductDataToPDF.dart';

import '../../celement/elements.dart';
import 'package:intl/intl.dart';

import '../../notifire/productNotifire.dart';
import '../buttonReportData.dart';

class ReportProductData extends StatefulWidget {
  const ReportProductData({Key? key}) : super(key: key);

  @override
  State<ReportProductData> createState() => _ReportProductDataState();
}

class _ReportProductDataState extends State<ReportProductData> {
  @override
  Widget build(BuildContext context) {
    ProductNotifire pro = Provider.of<ProductNotifire>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ລາຍງານຂໍ້ມູນສິນຄ້າ'),
        centerTitle: true,
        backgroundColor: element.pink,
        leading: element().RoutePageBack(context, const ReportData()),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(height: 5.0),
                    SizedBox(
                      child: Text(
                        'ລາຄາ',
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
              itemCount: pro.Products.length,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            '${pro.Products[index].nameProduct}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          child: Text(
                            '${pro.Products[index].amount}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          child: Text(
                            '${pro.Products[index].category_id}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          child: Text(
                            NumberFormat.decimalPattern()
                                .format(pro.Products[index].price),
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
              Text('ທັ້ງໝົດ: ${pro.Products.length} ລາຍການ',
                  style: const TextStyle(fontSize: 17)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            width: double.maxFinite,
            height: 55,
            child: ElevatedButton(
                onPressed: () {
                  ProductPDF.SaveProductPDF(pro, context);
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
