// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skin_care/api/Delete/Delete_category.dart';

import '../api/Delete/Delete_emp.dart';
import '../api/Delete/Delete_product.dart';
import '../api/Delete/Delete_supp.dart';

Dialog_D(context,
    {var notifire, required String? name, required String? typefuction}) {
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ທ່ານເເນ່ໃຈລະບໍ່ທີ່ຈະລົບຂໍ້ມູນ:',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('  $name !',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 55,
                      child: ElevatedButton(
                        child: const Text(
                          'ລົບ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        onPressed: () async {
                          switch (typefuction) {
                            case 'cate':
                              await Delete_Category(notifire);
                              Navigator.pop(context);
                              break;
                            case 'products':
                              await Delete_products(notifire);
                              Navigator.pop(context);
                              break;
                            case 'supplier':
                              await Delete_supp(notifire);
                              Navigator.pop(context);
                              break;
                            case 'employee':
                              await Delete_emp(notifire);
                              Navigator.pop(context);
                              break;
                          }
                        },
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

Dialog_Cire(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(color: Color(0xff0031CA)),
    ),
  );
}

ShowMessage({
  String? text,
  required bool type,
}) {
  Fluttertoast.showToast(
      msg: type
          ? 'ເພີ່ມຂໍ້ມູນ $text ສຳເລັດແລ້ວ'
          : 'ແກ້ໄຂຂໍ້ມູນ $text ສຳເລັດແລ້ວ',
      fontSize: 20,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      timeInSecForIosWeb: 3);
}
