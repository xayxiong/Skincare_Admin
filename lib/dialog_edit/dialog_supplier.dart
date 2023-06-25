// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';


import '../api/update_data/update_supplier.dart';
import '../notifire/supplierNotifire.dart';
import 'dialog_and_snackbar.dart';

class SupplierDialog {
  final GlobalKey<FormState> _key_import = GlobalKey<FormState>();
  Dialog({required BuildContext context, required SupplierNotifire supp}) {
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
                        child: SizedBox(
                          width: 400,
                          height: 360,
                          child: Card(
                              child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  initialValue: supp.CurrentSupplier!.name,
                                  decoration: const InputDecoration(
                                    hintText: "ຊື່ ແລະ ນາມສະກຸນ",
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                  onSaved: (value) {
                                    supp.CurrentSupplier!.name = value;
                                  },
                                  validator: (cost) {
                                    if (cost!.isEmpty) {
                                      return "ກະລຸນາປ້ອນຂໍ້ມູນ";
                                    } else if (cost.length < 2) {
                                      return "ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຖືກຕ້ອງ";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  initialValue: supp.CurrentSupplier!.email,
                                  decoration: const InputDecoration(
                                    hintText: "ອີເມວ",
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  onSaved: (value) {
                                    supp.CurrentSupplier!.email = value;
                                  },
                                  validator: (amout) {
                                    if (amout!.isEmpty) {
                                      return "ກະລຸນາປ້ອນຂໍ້ມູນ";
                                    } else if (amout.isEmpty) {
                                      return "ກວດສວບລາຄາ";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  initialValue: supp.CurrentSupplier!.tel,
                                  decoration: const InputDecoration(
                                    hintText: "ເບີໂທລະສັບ",
                                    prefixIcon: Icon(Icons.phone),
                                  ),
                                  onSaved: (value) {
                                    supp.CurrentSupplier!.tel = value;
                                  },
                                  validator: (cost) {
                                    if (cost!.isEmpty) {
                                      return "ກະລຸນາປ້ອນຂໍ້ມູນ";
                                    } else if (cost.length < 4) {
                                      return "ກວດສວບລາຄາ";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  initialValue: supp.CurrentSupplier!.address,
                                  decoration: const InputDecoration(
                                    hintText: "ທີ່ຢູ່",
                                    prefixIcon: Icon(Icons.home),
                                  ),
                                  onSaved: (value) {
                                    supp.CurrentSupplier!.address = value;
                                  },
                                  validator: (cost) {
                                    if (cost!.isEmpty) {
                                      return "ກະລຸນາປ້ອນຂໍ້ມູນ";
                                    } else if (cost.length < 4) {
                                      return "ກວດສວບລາຄາ";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  initialValue:
                                      supp.CurrentSupplier!.supplyProduct,
                                  decoration: const InputDecoration(
                                    hintText: "ສິນຄ້າຜູ້ສະໜອງ",
                                    prefixIcon: Icon(
                                        Icons.production_quantity_limits_sharp),
                                  ),
                                  onSaved: (value) {
                                    supp.CurrentSupplier!.supplyProduct = value;
                                  },
                                  validator: (cost) {
                                    if (cost!.isEmpty) {
                                      return "ກະລຸນາປ້ອນຂໍ້ມູນ";
                                    } else if (cost.length < 4) {
                                      return "ກວດສວບລາຄາ";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: 300,
                                  height: 55,
                                  child: ElevatedButton(
                                    child: const Text(
                                      'ບັນທືກ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    onPressed: () async {
                                      if (_key_import.currentState!
                                          .validate()) {
                                        _key_import.currentState!.save();
                                        await Update_supplier(supp);
                                       await ShowMessage(
                                            type: false,
                                            text: supp.CurrentSupplier!.name);

                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
