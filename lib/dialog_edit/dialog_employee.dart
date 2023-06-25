  // ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../api/update_data/update_Employee.dart';
import '../model/Employee_Model.dart';
import '../notifire/employeeNotifire.dart';
import 'dialog_and_snackbar.dart';

class EmployeeDialog {
  final GlobalKey<FormState> _key_import = GlobalKey<FormState>();
  String? email, pass;
  Dialog(context, EmployeeNotifire emp) {
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
                          height: 480,
                          child: Card(
                              child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  initialValue: emp.CurrentEmployee!.name,
                                  decoration: const InputDecoration(
                                    hintText: "ຊື່ ແລະ ນາມສະກຸນ",
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                  onSaved: (value) {
                                    emp.CurrentEmployee!.name = value;
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
                                  initialValue: emp.CurrentEmployee!.email,
                                  decoration: const InputDecoration(
                                    hintText: "ອີເມວ",
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  onSaved: (value) {
                                    email = value!;
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
                                ////////////////////////////////////////////////

                                TextFormField(
                                  initialValue: emp.CurrentEmployee!.password,
                                  decoration: const InputDecoration(
                                    hintText: "ລະຫັດ",
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                  onSaved: (value) {
                                    pass = value!;
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
                                  initialValue: emp.CurrentEmployee!.tel,
                                  decoration: const InputDecoration(
                                    hintText: "ເບີໂທ",
                                    prefixIcon: Icon(Icons.phone),
                                  ),
                                  onSaved: (value) {
                                    emp.CurrentEmployee!.tel = value;
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
                                  initialValue: emp.CurrentEmployee!.birthday,
                                  decoration: const InputDecoration(
                                    hintText: "ວັນ ເດືອນ ປີເກີດ",
                                    prefixIcon: Icon(Icons.people),
                                  ),
                                  onSaved: (v) {
                                    emp.CurrentEmployee!.birthday = v;
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
                                DropdownButton(
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                    value: emp.CurrentEmployee!.position,
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

                                    items: EmployeeData.positoin
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text('${e}'),
                                            )))
                                        .toList(),
                                    onChanged: (v) {
                                      Navigator.pop(context);
                                      EmployeeDialog().Dialog(context, emp);
                                      emp.CurrentEmployee!.position =
                                          v.toString();
                                    }),
                                const SizedBox(height: 5),
                                TextFormField(
                                  initialValue: emp.CurrentEmployee!.address,
                                  decoration: const InputDecoration(
                                    hintText: "ທີ່ຢູ່",
                                    prefixIcon: Icon(Icons.home),
                                  ),
                                  onSaved: (_address) {
                                    emp.CurrentEmployee!.address = _address;
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
                                        await update_Employee(emp,
                                            email: email!, pass: pass!);
                                       ShowMessage(type: false, text: 'ພະນັກງານ');
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
