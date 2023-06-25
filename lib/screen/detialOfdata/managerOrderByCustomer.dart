// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names, depend_on_referenced_packages, use_build_context_synchronously, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/notifire/OrderNotifire.dart';
import 'package:intl/intl.dart';
import 'package:skin_care/report/buttonReportData.dart';
import 'package:skin_care/screen/manageOrder.dart';
import 'package:skin_care/celement/elements.dart';
import '../../Order_detill/View_order_cutommer.dart';
import '../../api/Update status/Status.dart';
import '../../api/get_Order.dart';

class ManagerOrderByCustomer extends StatefulWidget {
  bool tpye;
  ManagerOrderByCustomer(this.tpye, {Key? key}) : super(key: key);

  @override
  State<ManagerOrderByCustomer> createState() =>
      _ManagerOrderByCustomerState(this.tpye);
}

class _ManagerOrderByCustomerState extends State<ManagerOrderByCustomer> {
  bool tpye;
  _ManagerOrderByCustomerState(this.tpye);
  @override
  Widget build(BuildContext context) {
    Order_Notifire order = Provider.of<Order_Notifire>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ລູກຄ້າສັ່ງຊື້ສິນຄ້າ'),
        centerTitle: true,
        backgroundColor: element.pink,
        leading: element().RoutePageBack(
            context, tpye ? const ManageOrder() : const ReportData()),
      ),
      body: ListView.builder(
        itemCount: order.Order.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () async {
                    order.Curren_Order = order.Order[index];
                    await Get_Order_Detlill(order);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const view_order()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              'ລະຫັດ: ${order.Order[index].id}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 30),
                            Text(
                              '${order.Order[index].date!.toDate().toString().substring(0, 10)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'ຊື່ລູກຄ້າ: ${order.Order[index].nameCutommer}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'ເບີໂທ: ${order.Order[index].tel} ',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'ຈຳນວນ: ${order.Order[index].Ditell.length} ລາຍການ',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'ຈຳນວນທັງໝົດ: ${order.Order[index].amouttotal} ອັນ',
                        style: const TextStyle(fontSize: 16),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              'ລາຄາລວມ: ${NumberFormat.decimalPattern().format(order.Order[index].sumtotal)} ກີບ',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 120),
                            Staustus(order, index),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget Staustus(Order_Notifire order, int index) {
    return order.Order[index].Staustus == 'ລໍຖ້າ'
        ? ElevatedButton(
            onPressed: () async {
              order.Curren_Order = order.Order[index];
              await update_Status(order);
              await Get_Order(Order: order);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('${order.Order[index].Staustus}'),
          )
        : ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('${order.Order[index].Staustus}'),
          );
  }
}
