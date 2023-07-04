import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/celement/elements.dart';
import 'package:skin_care/route/router.dart';

import '../notifire/employeeNotifire.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    EmployeeNotifire emp = Provider.of<EmployeeNotifire>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: element.pink,
        shadowColor: Colors.grey[300],
        iconTheme: const IconThemeData(color: Colors.white),
        title: Center(
          child: Text(
            element.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        // actions: [element.CartButton(context, route.Cart)],
      ),
      drawer: buildDrawer(emp),
      body: Container(
        color: Colors.grey[300],
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 0.5),
          children: [
            // element.MenuButton(
            //     context, route.prodc, Icons.shop, element.pink, element.p1),
            element.MenuButton(context, route.m_orders, Icons.border_outer_rounded,
                element.ocean, element.p3),
            // element.MenuButton(context, route.MnagerOrderByAdmin,
            //     Icons.shopping_cart, element.sky, element.p8),
            element.MenuButton(context, route.product, Icons.add,
                element.sky, element.p4),
            // element.MenuButton(context, route.suppliyer, Icons.people,
            //     element.sky, element.p5),
            element.MenuButton(context, route.register, Icons.person,
                element.Indigo, element.p2),
            element.MenuButton(context, route.product_type, Icons.category,
                element.sky, element.p6),
            element.MenuButton(context, route.reportData, Icons.report_sharp,
                element.gray, element.p7),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer(EmployeeNotifire emp) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff281E5D),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('ຮ້ານຂາຍເຄື່ອງສຳອາງອອນລາຍ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white)),
                SizedBox(height: 10),
                Text('${emp.CurrentEmployee_loco!.id}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white)),
                Text('${emp.CurrentEmployee_loco!.name}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white)),
                Expanded(
                    child: Text('${emp.CurrentEmployee_loco!.email}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white))),
              ],
            ),
          ),
          // buildListTile(element.p1, route.prodc),
          buildListTile(element.p2, route.register),
          buildListTile(element.p3, route.m_orders),
          buildListTile(element.p4, route.product),
          // buildListTile(element.p5, route.suppliyer),
        ],
      ),
    );
  }

  ListTile buildListTile(txt, rout) {
    return ListTile(
        title: Text(txt),
        onTap: () {
          Navigator.pushNamed(context, rout);
        });
  }
}
