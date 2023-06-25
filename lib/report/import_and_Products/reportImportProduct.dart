import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/getImportProduct.dart';
import '../../celement/elements.dart';
import '../../notifire/supplierNotifire.dart';
import '../buttonReportData.dart';
import 'Detail_import_Product.dart';

class ReportImportProduct extends StatefulWidget {
  const ReportImportProduct({Key? key}) : super(key: key);

  @override
  State<ReportImportProduct> createState() => _ReportImportProductState();
}

class _ReportImportProductState extends State<ReportImportProduct> {
  @override
  Widget build(BuildContext context) {
    SupplierNotifire supp = Provider.of<SupplierNotifire>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('ລາຍງານໃບນຳສົ່ງສິນຄ້າ'),
          centerTitle: true,
          backgroundColor: element.pink,
          leading: element().RoutePageBack(context, const ReportData()),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            const Text('ໃບນຳສົ່ງສິນຄ້າ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: supp.Supplier.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      supp.CurrenimportP_id = supp.ImportProduct[index];
                      supp.CurrentSupplier = supp.Supplier[index];
                      get_Detail_ImPortProduct(supp);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Detaiy_import_product()));
                    },
                    child: Card(
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            side: BorderSide(width: 1, color: Colors.green)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // color: c,
                                  width: 115,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(18),
                                    ),
                                  ),
                                  child: Text(
                                    '  ລະຫັດ: ${supp.ImportProduct[index].id}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: element.wht,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    supp.ImportProduct[index].date!
                                        .toDate()
                                        .toString()
                                        .substring(0, 16),
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 10, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 5.0),
                                  Text(
                                    'ຜູ້ສະໜອງ: ${supp.Supplier[index].name}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ເບີໂທ: ${supp.SuplierList[index].tel}',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios,
                                          size: 14)
                                    ],
                                  ),
                                  Text(
                                    'ອີເມວ: ${supp.SuplierList[index].email}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ຈຳນວນສັ່ງຊື້ທັງໝົດ: ${supp.ImportProduct[index].amouttotal} ອັນ',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        '${index + 1} ',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
