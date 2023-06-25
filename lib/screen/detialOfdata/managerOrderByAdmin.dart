import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../api/UploadData/Get_Data_phuasOrder.dart';
import '../../api/UploadData/upload_importproduct.dart';
import '../../api/getsupplier.dart';
import '../../celement/elements.dart';
import '../../common/Bill.dart';
import '../../dialog_edit/dialog_and_snackbar.dart';
import '../../model/importproducts_Model.dart';
import '../../notifire/import_product.dart';
import '../../notifire/purchase_order_Notifire.dart';
import '../../notifire/supplierNotifire.dart';
import '../manageOrder.dart';
import '../splashScreen.dart';

class ManagerOrderByAdmin extends StatefulWidget {
  const ManagerOrderByAdmin({Key? key}) : super(key: key);

  @override
  State<ManagerOrderByAdmin> createState() => _ManagerOrderByAdminState();
}

class _ManagerOrderByAdminState extends State<ManagerOrderByAdmin> {
  @override
  void initState() {
    super.initState();
    dos();
  }

  Future dos() async {
    SupplierNotifire supp =
        Provider.of<SupplierNotifire>(context, listen: false);
    await GetSupplier(supp);
  }

  @override
  Widget build(BuildContext context) {
    purchase_order_Notifire orderadmin =
        Provider.of<purchase_order_Notifire>(context);
    SupplierNotifire supp = Provider.of<SupplierNotifire>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ເລືອກຜູ້ສະໜອງທີ່ສັ່ງຊື້'),
        centerTitle: true,
        backgroundColor: element.pink,
        leading: element().RoutePageBack(context, const ManageOrder()),
      ),
      body: ListView.builder(
        itemCount: supp.SuplierList.length,
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () async {
                  supp.CurrentSupplier = supp.SuplierList[index];
                  await GetPureChaseNoly(order_admin: orderadmin, supp: supp);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Show_order_addmin()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ຊື່ຜູ້ສະໜອງ:  ${supp.SuplierList[index].name}',
                        style: const TextStyle(fontSize: 15)),
                    Text('ເບີໂທລະສັບ: ${supp.SuplierList[index].tel}',
                        style: const TextStyle(fontSize: 15)),
                    Text('ທີ່ຢູ່: ${supp.SuplierList[index].address}',
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

///////////========////////// ລາຍການສັ່ງຊື້ຈາກຜູ້ສະໜອງ //////========////////////////========////////////
class Show_order_addmin extends StatefulWidget {
  const Show_order_addmin({Key? key}) : super(key: key);

  @override
  State<Show_order_addmin> createState() => _Show_order_addminState();
}

class _Show_order_addminState extends State<Show_order_addmin> {
  @override
  Widget build(BuildContext context) {
    purchase_order_Notifire orderadmin =
        Provider.of<purchase_order_Notifire>(context);
    SupplierNotifire supp = Provider.of<SupplierNotifire>(context);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('ລາຍການສັ່ງຊື້ຈາກຜູ້ສະໜອງ'),
          centerTitle: true,
          backgroundColor: element.pink,
          leading:
              element().RoutePageBack(context, const ManagerOrderByAdmin()),
        ),
        body: ListView.builder(
          itemCount: orderadmin.Order_addminlist.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                margin: const EdgeInsets.all(10),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () async {
                        orderadmin.Currenorderaddmin =
                            await orderadmin.Order_addminlist[index];
                        await orderadmin.Curren();
                        await GetDetill(order_admin: orderadmin);
                        orderadmin.Refresh();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Detellorder_addmid()));
                      },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('ລະຫັດ: '
                                    ' ${orderadmin.Order_addminlist[index].id}            '),
                                Text(
                                  ' ${orderadmin.Order_addminlist[index].date!.toDate().toString().substring(0, 10)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text('ຊື່ຜູ້ສະໜອງ: '
                                ' ${supp.CurrentSupplier!.name}'),
                            Text('ຈຳນວນ: '
                                ' ${orderadmin.Order_addminlist[index].Ditell.length} ລາຍການ'),
                            Text('ຈຳນວນທັງໝົດ: '
                                ' ${orderadmin.Order_addminlist[index].amouttotal} ອັນ'),
                          ]),
                    )),
              ),
            );
          },
        ));
  }
}

///////////  ============= ຂໍ້ມູນລາຍລະອຽດຂອງການສັ່ງຊື້'  ///////////=======////ຂໍ້ມູນລາຍລະອຽດຂອງການສັ່ງຊື້'/////////////////////////
class Detellorder_addmid extends StatefulWidget {
  const Detellorder_addmid({Key? key}) : super(key: key);

  @override
  State<Detellorder_addmid> createState() => _Detellorder_addmidState();
}

class _Detellorder_addmidState extends State<Detellorder_addmid> {
  @override
  initState() {
    super.initState();
    purchase_order_Notifire orderadmin =
        Provider.of<purchase_order_Notifire>(context, listen: false);
    GetDetill(order_admin: orderadmin);
  }

  @override
  Widget build(BuildContext context) {
    purchase_order_Notifire orderadmin =
        Provider.of<purchase_order_Notifire>(context);
    SupplierNotifire supp = Provider.of<SupplierNotifire>(context);
    importproductNotifire impit_product =
        Provider.of<importproductNotifire>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ຂໍ້ມູນລາຍລະອຽດຂອງການສັ່ງຊື້'),
        centerTitle: true,
        backgroundColor: element.pink,
        leading: element().RoutePageBack(context, const Show_order_addmin()),
      ),
      body: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 10,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ຊື່ຜູ້ສະໜອງ:  ${supp.CurrentSupplier!.name}'),
                    Text('ທີ່ຢູ່: ${supp.CurrentSupplier!.address}'),
                    Text('ເບີໂທ: ${supp.CurrentSupplier!.tel}'),
                    Text('ອີເມວ: ${supp.CurrentSupplier!.email}'),
                    Text(
                        'ວັນທີສັ່ງຊື້: ${orderadmin.Currenorderaddmin!.date!.toDate()}'),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: orderadmin.Dettil.length,
                    itemBuilder: (context, index) {
                      if (orderadmin.Product_categoryname.length != 0) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                    '${orderadmin.Productditill[index].image}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                          'ຊື່ສິນຄ້າ: ${orderadmin.Productditill[index].nameProduct}'),
                                      Text(
                                          'ປະເພດສິນຄ້າ: ${orderadmin.Product_categoryname[index].category}'),
                                      Text(
                                          'ຈຳນວນ: ${orderadmin.Productditill[index].amount} ອັນ'),
                                    ],
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      orderadmin.Productaddmin =
                                          orderadmin.Productditill[index];
                                      _Dialog(
                                          orderadmin, context, impit_product);
                                    },
                                    child: const Text('ເພີ່ມ')),
                              ],
                            )
                          ],
                        );
                      } else {
                        GetDetill(order_admin: orderadmin);
                        return Row(
                          children: [
                            CircularProgressIndicator(
                              color: element.pink,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          'ຈຳນວນທັງໝົດ: ${orderadmin.Currenorderaddmin!.amouttotal} ອັນ'),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: element.pink),
                        child: const Text('ບັນທຶກເປັນພີດີເອຟ'),
                        onPressed: () async {
                          permissionCheck();
                          Bill.save_Bill(orderadmin, context, supp);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<Widget> permissionCheck() async {
    var permissionStatus = await Permission.storage.status;

    if (!permissionStatus.isGranted) {
      await Permission.storage.request();
      print('permit');
    }
    permissionStatus = await Permission.storage.status;
    if (permissionStatus.isGranted)
      return SplashScreen();
    else {
      return AlertDialog(
        title: const Text(
            'Permission Required'), // To display the title it is optional
        content: const Text(
            'Cannot proceed without permission'), // Message which will be pop up on the screen
        // Action widget which will provide the user to acknowledge the choice
        actions: [
          TextButton(
            // FlatButton widget is used to make a text to work like a button
            child: const Text('Open App Settings'),
            onPressed: () => openAppSettings(),
            // function used to perform after pressing the button
          ),
        ],
      );
    }
  }

  //////////=======////////=======/////////=======///////
  final GlobalKey<FormState> _key_import = GlobalKey<FormState>();
  int? amouts, costs, amoutall;

  _Dialog(purchase_order_Notifire orderaddmin, context,
      importproductNotifire improtduct) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.indeterminate_check_box_outlined,
                        color: Colors.red, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Column(
                    children: [
                      Form(
                        key: _key_import,
                        child: Container(
                          width: 400,
                          height: 350,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'ເພີ່ມສິນຄ້າຜູ້ສະໜອງ',
                                  style: TextStyle(fontSize: 20),
                                ),

                                const SizedBox(height: 10),
                                Text(
                                  'ຊື່ສິນຄ້າ:  ${orderaddmin.Productaddmin!.nameProduct}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'ຈຳນວນ:  ${orderaddmin.Productaddmin!.amount} ລາຍການ',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(height: 2),
                                ////////////////////////////////////////////////
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "ລາຄາທືນ",
                                    fillColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.1),
                                    filled: true,
                                    prefixIcon: const Icon(Icons.price_check),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onSaved: (cost) {
                                    costs = int.parse(cost!);
                                  },
                                  validator: (cost) {
                                    if (cost!.isEmpty) {
                                      return "ກະລຸນາປ້ອນຂໍ້ມູນ";
                                    } else if (cost.length < 4) {
                                      return "ກວດສວບລາຄາ";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    amoutall = costs! * amouts!;
                                  },
                                ),
                                const SizedBox(height: 10),
                                /////////////////////////////////////////
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "ຈຳນວນ",
                                    fillColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.1),
                                    filled: true,
                                    prefixIcon: const Icon(Icons.numbers),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onSaved: (amout) {
                                    amouts = int.parse(amout!);
                                  },
                                  validator: (amout) {
                                    if (amout!.isEmpty) {
                                      return "ກະລຸນາປ້ອນຂໍ້ມູນ";
                                    } else if (amout.length < 1) {
                                      return "ກວດສວບລາຄາ";
                                    }
                                    return null;
                                  },
                                ),
                                // const SizedBox(height: 10),
                                // Text('ລາຄາລວມ : ${amoutall}ຂອງສິນຄ້າ'),
                                const SizedBox(height: 40),

                                Container(
                                  width: 300,
                                  height: 50,
                                  child: ElevatedButton(
                                    child: const Text('ບັນທືກ'),
                                    onPressed: () async {
                                      if (_key_import.currentState!
                                          .validate()) {
                                        _key_import.currentState!.save();
                                        if (costs != null &&
                                            amouts != null &&
                                            orderaddmin.Currenorderaddmin !=
                                                null) {
                                          improtduct.impt_product =
                                              await import_products(
                                                  cost: costs,
                                                  amout: amouts,
                                                  sumtotal: costs! * amouts!,
                                                  id_products: orderaddmin
                                                      .Productaddmin!.id,
                                                  id_purchase: orderaddmin
                                                      .Currenorderaddmin!.id);
                                          improtduct.Refresh();
                                          await Upload_import_product(
                                              improtduct);
                                          ShowMessage(
                                              type: true,
                                              text:
                                                  '${orderaddmin.Productaddmin!.nameProduct} $amouts ຈຳນວນ ');
                                          _key_import.currentState!.reset();
                                          Navigator.pop(context);
                                        } else {
                                          print('no');
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
