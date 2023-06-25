// ignore_for_file: sized_box_for_whitespace



import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/notifire/OrderNotifire.dart';

import '../api/get_Order.dart';
import '../celement/elements.dart';
import 'detialOfdata/managerOrderByCustomer.dart';
import 'menu.dart';

class ManageOrder extends StatefulWidget {
  const ManageOrder({Key? key}) : super(key: key);

  @override
  State<ManageOrder> createState() => _ManageOrderState();
}

late double sreenWidth, sreenHeight;

class _ManageOrderState extends State<ManageOrder> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    Order_Notifire Order = Provider.of<Order_Notifire>(context);
    sreenWidth = MediaQuery.of(context).size.width;
    sreenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("error"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('ຈັດການອໍເດີ້'),
                centerTitle: true,
                backgroundColor: element.pink,
                leading: element().RoutePageBack(context, const Menu()),
              ),
              body: Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: element.pink),
                        onPressed: () {
                          Get_Order(Order: Order);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ManagerOrderByCustomer(true)));
                        },
                        child: const Text(
                          'ລູກຄ້າສັ່ງຊື້ສິນຄ້າ',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              )));
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
