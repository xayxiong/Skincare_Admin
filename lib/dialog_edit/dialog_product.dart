// ignore_for_file: camel_case_types, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, prefer_is_empty

import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_care/celement/elements.dart';




import '../api/update_data/update_product.dart';
import '../notifire/categoryNotifire.dart';
import '../notifire/productNotifire.dart';
import 'dialog_and_snackbar.dart';

class ProductDialogState {
  int index = 0;
  Future<XFile> AddImages() async {
    XFile? _image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return _image!;
  }

  final GlobalKey<FormState> _key_import = GlobalKey<FormState>();
  double area = 55;
  double h =0;
  Dialog(
      {required context,
      required ProductNotifire product,
      required CategoryNotifire cate}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: SingleChildScrollView(
              child: AlertDialog(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.indeterminate_check_box_outlined,
                        color: Colors.red, size: 30),
                    onPressed: () {
                      cate.categoryType = null;
                      product.CurrentProduct!.category_id = null;
                      product.ChangeImage = null;
                      Navigator.pop(context);
                    },
                  ),
                  Column(
                    children: [
                      Form(
                        key: _key_import,
                        child: SizedBox(
                          width: 400,
                          height: 500,
                          child: Card(
                              child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: GestureDetector(
                                    onDoubleTap: () {},
                                    onTap: () async {
                                      AddImages().then((value) {
                                        product.image(value);
                                        Navigator.pop(context);
                                        ProductDialogState().Dialog(
                                            context: context,
                                            product: product,
                                            cate: cate);
                                      });
                                    },
                                    child: CircleAvatar(
                                        radius: 80,
                                        backgroundColor: element.wht,
                                        child: product.ChangeImage != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  File(product
                                                      .ChangeImage!.path),
                                                  width: 200,
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : Container(
                                                height: 200,
                                                width: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                Image.network(
                                                              "${product.CurrentProduct!.image}",
                                                              width: 150,
                                                              height: 140,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                  ),
                                ),
                                TextFormField(
                                  initialValue:
                                      product.CurrentProduct!.nameProduct,
                                  decoration: const InputDecoration(
                                    hintText: "ຊື່ສິນຄ້າ",
                                    prefixIcon: Icon(
                                        Icons.production_quantity_limits_sharp),
                                  ),
                                  onChanged: (value) {
                                    product.CurrentProduct!.nameProduct = value;
                                  },
                                  onSaved: (value) {
                                    product.CurrentProduct!.nameProduct = value;
                                  },
                                  validator: (cost) {
                                    if (cost!.isEmpty) {
                                      return "ກະລຸນາປ້ອນຂໍ້ມູນ";
                                    } else if (cost.length < 2) {
                                      return "ກະລຸນາໃສ່ຂໍ້ມູນໃຫ້ຖືກຕ້ອງ";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  initialValue:
                                      product.CurrentProduct!.price.toString(),
                                  decoration: const InputDecoration(
                                    hintText: "ລາຄາ",
                                    prefixIcon:
                                        Icon(Icons.price_check_outlined),
                                  ),
                                  onChanged: (value) {
                                    product.CurrentProduct!.price =
                                        int.parse(value);
                                  },
                                  onSaved: (value) {
                                    product.CurrentProduct!.price =
                                        int.parse(value!);
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
                                  initialValue:
                                      product.CurrentProduct!.amount.toString(),
                                  decoration: const InputDecoration(
                                    hintText: "ຈຳນວນ",
                                    prefixIcon: Icon(Icons.qr_code),
                                  ),
                                  onChanged: (value) {
                                    product.CurrentProduct!.amount =
                                        int.parse(value);
                                  },
                                  onSaved: (value) {
                                    product.CurrentProduct!.amount =
                                        int.parse(value!);
                                  },
                                  validator: (cost) {
                                    if (cost!.isEmpty) {
                                      return "ກະລຸນາປ້ອນຂໍ້ມູນ";
                                    } else if (cost.length < 1) {
                                      return "ກວດສວບລາຄາ";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 5),
                                DropdownButton(
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                    value: product.CurrentProduct!.category_id,
                                    isExpanded: true,
                                    underline: const SizedBox(
                                      height: 4,
                                      child: Divider(
                                        indent: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    hint: const Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text("ເລືອກປະເພດສິນຄ້າ"),
                                    ),
                                    // icon: const Icon(Icons.keyboard_arrow_down),

                                    items: cate.cate
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text(
                                                  '${cate.categoryList[index++].category}'),
                                            )))
                                        .toList(),
                                    onChanged: (String? v) {
                                      Navigator.pop(context);
                                      ProductDialogState().Dialog(
                                          context: context,
                                          product: product,
                                          cate: cate);
                                      cate.SelectType(v);
                                      product.CurrentProduct!.category_id = v;
                                      print(
                                          product.CurrentProduct!.category_id);
                                    }),
                                const SizedBox(height: 5),
                                TextFormField(
                                  initialValue:
                                      product.CurrentProduct!.description,
                                  decoration: const InputDecoration(
                                    hintText: "ລາຍລະອຽດ",
                                    prefixIcon: Icon(Icons.details_sharp),
                                  ),
                                  onChanged: (value) {
                                    product.CurrentProduct!.description = value;
                                  },
                                  onSaved: (value) {
                                    product.CurrentProduct!.description = value;
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
                                 SizedBox(height: h),
                                Container(height: h,),
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
                                      product.RefreshProduct();
                                      if (_key_import.currentState!
                                          .validate()) {
                                        _key_import.currentState!.save();
                                        await Update_products(product);
                                        ShowMessage(
                                            type: false,
                                            text: product.CurrentProduct!.nameProduct);
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                )
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
