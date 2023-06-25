// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/report/reportEmployeeData.dart';


import '../api/Getrepoert/get_report_Expanese.dart';
import '../api/Getrepoert/get_reportl_income.dart';
import '../api/getEmployeeData.dart';

import '../api/getProduct.dart';
import '../api/get_Order.dart';
import '../celement/elements.dart';
import '../notifire/OrderNotifire.dart';
import '../notifire/Repport_Notifire.dart';
import '../notifire/employeeNotifire.dart';
import '../notifire/productNotifire.dart';

import '../screen/detialOfdata/managerOrderByCustomer.dart';
import '../screen/menu.dart';
import 'import_and_Products/reportProductData.dart';
import 'income_expanes/reportExpense.dart';
import 'income_expanes/reportIncome.dart';

class ReportData extends StatefulWidget {
  const ReportData({Key? key}) : super(key: key);

  @override
  State<ReportData> createState() => _ReportDataState();
}

class _ReportDataState extends State<ReportData> {
  @override
  Widget build(BuildContext context) {
    report_incomeNotifire income = Provider.of<report_incomeNotifire>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('ລາຍງານຂໍ້ມູນ'),
          centerTitle: true,
          backgroundColor: element.pink,
          leading: element().RoutePageBack(context, const Menu()),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                color: element.pink,
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: element.pink),
                    onPressed: () {
                      Get_reportl_income(income);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReportIncome()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.pending_actions),
                        SizedBox(width: 10),
                        Text(
                          'ລາຍງານລາຍ ຮັບ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: element.pink),
                    onPressed: () {
                      Get_reportl_Expanese(income);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReportExpense()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.perm_device_information_sharp),
                        SizedBox(width: 10),
                        Text(
                          'ລາຍງານລາຍ ຈ່າຍ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: element.pink),
                    onPressed: () async {
                      EmployeeNotifire emp =
                          Provider.of<EmployeeNotifire>(context, listen: false);
                      await GetEmployeeData(emp);
                      emp.employeeList.toList().forEach((element) async {
                        await emp.CheckPosition(
                            element.position.toString(), emp);
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ReportEmployeeData()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline),
                        SizedBox(width: 10),
                        Text(
                          'ລາຍງານລາຍ ພະນັກງານ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )),
              ),
              // const SizedBox(height: 10),
              // SizedBox(
              //   height: 50,
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(primary: element.main),
              //     onPressed: () {
              //       SupplierNotifire supp =
              //           Provider.of<SupplierNotifire>(context, listen: false);
              //       getImPortProduct(supp);
              //       Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const ReportImportProduct()));
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.label_important_outline_rounded),
              //         SizedBox(width: 10),
              //         Text(
              //           'ລາຍງານລາຍການ ນຳເຂົ້າສິນຄ້າ',
              //           style: TextStyle(fontSize: 20),
              //         ),
              //       ],
              //     )
              //   ),
              // ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: element.pink),
                    onPressed: () async {
                      ProductNotifire product =
                          Provider.of<ProductNotifire>(context, listen: false);
                      GetProduct(product, false);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReportProductData()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined),
                        SizedBox(width: 10),
                        Text(
                          'ລາຍງານຂໍ້ມູນ ສິນຄ້າ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: element.pink),
                    onPressed: () async {
                      Order_Notifire Order =
                          Provider.of<Order_Notifire>(context, listen: false);
                      Get_Order(Order: Order, type: 'Wait');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ManagerOrderByCustomer(false)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.exit_to_app_outlined),
                        SizedBox(width: 10),
                        Text(
                          'ລາຍງານການ ສັ່ງຊື້ສິນຄ້າ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: element.pink),
                    onPressed: () async {
                      Order_Notifire Order =
                          Provider.of<Order_Notifire>(context, listen: false);
                      Get_Order(Order: Order, type: 'Dunt');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ManagerOrderByCustomer(false)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.book_outlined),
                        SizedBox(width: 10),
                        Text(
                          'ລາຍງານ ອໍເດີ້ທີ່ສຳເລັດ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )),
              ),
              // const SizedBox(height: 10),
              // SizedBox(
              //   height: 50,
              //   width: double.infinity,
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(primary: element.main),
              //       onPressed: () async {
              //         purchase_order_Notifire order_admin =
              //             Provider.of<purchase_order_Notifire>(context,
              //                 listen: false);
              //         SupplierNotifire supp =
              //             Provider.of<SupplierNotifire>(context, listen: false);
              //         getImPortProduct(supp);
              //         //   GetDetill(order_admin: order_admin,type: false);
              //         Navigator.pushReplacement(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => const purChase_Product()));
              //       },
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: const [
              //           Icon(Icons.import_export),
              //           SizedBox(width: 10),
              //           Text(
              //             'ລາຍງານການ ສັ່ງຊື້ເຂົ້າຮ້ານ',
              //             style: TextStyle(fontSize: 20),
              //           ),
              //         ],
              //       )),
              // ),
            ],
          ),
        )));
  }
}
