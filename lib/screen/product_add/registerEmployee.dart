// ignore_for_file: avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../celement/elements.dart';
import '../../dialog_edit/dialog_and_snackbar.dart';
import '../../model/Employee_Model.dart';
import '../menu.dart';
import '../showDataFromFirebase/viewEmployee.dart';

class EmployeeTapbar extends StatefulWidget {
  const EmployeeTapbar({Key? key}) : super(key: key);

  @override
  State<EmployeeTapbar> createState() => _EmployeeTapbarState();
}

class _EmployeeTapbarState extends State<EmployeeTapbar> {


  
  @override
  Widget build(BuildContext context) {
    return element().TabbarPage(
        label1: ' ເພີ່ມຂໍ້ມູນພະນັກງານ',
        icos1: Icons.ad_units,
        icos2: Icons.feed,
        label2: 'ຂໍ້ມູນຂອງພະນັກງານແຕ່ລະຄົນ',
        tap1: const Register(),
        tap2: const ViewEmployee());
  }
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

final formKey = GlobalKey<FormState>();

String? name,
    birthday,
    email,
    password,
    confirmPassword,
    tel,
    address,
    position;
bool set = false;

final Future<FirebaseApp> firebase = Firebase.initializeApp();

class _RegisterState extends State<Register> {
  element elemnts = element();

  check() async {
    //up to database
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Dialog_Cire(context);
      if (position != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: email!, password: password!)
              .then((value) async {
            formKey.currentState!.reset();
            Fluttertoast.showToast(
              msg: "ລົງທະບຽນໄດ້ແລ້ວ",
              fontSize: 20,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.white,
              textColor: Colors.black,
            );
            String uid = value.user!.uid;
            print("uid = $uid");
            int id = await Random().nextInt(90) + 1000;
            EmployeeData employeeData = EmployeeData(
                id: id.toString(),
                name: name!,
                email: email!,
                password: password!,
                tel: tel!,
                address: address!,
                position: position!,
                birthday: birthday);
            final Map<String, dynamic>? data = employeeData.toMap();

            await FirebaseFirestore.instance
                .collection("employees")
                .doc(id.toString())
                .set(data!)
                .then(
              (value) {
                Navigator.pop(context);
                print('Insert value in to fireStore success');
                setState(() {
                  position = null;
                });
              },
            );
          });
        } on FirebaseAuthException catch (e) {
          // print(e.message);
          // print(e.code);
          Fluttertoast.showToast(
            msg: e.message!,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.blue,
          );
        }
      } else {
        return elemnts.showdialog(context,
            title: 'ຍັງບໍ່ທັນໄດ້ເລືອກຕຳເເໜ່ງ', content: 'ກະລຸນາເລືອກຕຳເເໜ່ງ');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Error"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "ລົງທະບຽນຂໍ້ມູນພະນັກງານ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: element.pink,
              leading: element().RoutePageBack(context, const Menu()),
              centerTitle: true,
            ),
            body: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _header(context),
                      const SizedBox(height: 20),
                      _inputFields(context),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  _header(context) {
    return Column(
      children: const [
        Text(
          "ຮ້ານຂາຍເຄື່ອງສຳອາງອອນລາຍ",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _inputFields(context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
              decoration: InputDecoration(
                hintText: "ຊື່ ແລະ ນາມສະກຸນ",
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => name = value.trim(),
              validator: (String? name) {
                if (name!.isEmpty) {
                  return "ກະລຸນາປ້ອນຊື່ ແລະ ນາມສະກຸນ";
                } else if (name.length < 3) {
                  return "ຊື່ ແລະ ນາມສະກຸນມັນສັ້ນເກີນໄປ";
                }
                name = name.toString();
                return null;
              }),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              hintText: "ອີເມວ",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value.trim(),
            validator: MultiValidator(
              [
                RequiredValidator(errorText: "ກະລຸນາປ້ອນອີເມວ"),
                EmailValidator(errorText: "ຮູບແບບອີເມວບໍ່ຖືກຕ້ອງ"),
              ],
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              hintText: "ລະຫັດຜ່ານ",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.text,
            obscureText: true,
            onChanged: (value) => password = value.trim(),
            validator: (String? password) {
              if (password!.isEmpty) {
                return "ກະລຸນາປ້ອນລະຫັດຜ່ານ";
              } else if (password.length < 6) {
                return "ລະຫັດຜ່ານມັນສັ້ນເກີນໄປ";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              hintText: "ຍືນຍັນລະຫັດຜ່ານ",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            obscureText: true,
            keyboardType: TextInputType.text,
            onChanged: (value) => confirmPassword = value.trim(),
            validator: (String? confirmPassword) {
              if (confirmPassword == password) {
                return null;
              } else if (confirmPassword != password) {
                return "ລະຫັດ ແລະ ຄອນເຟີມລະຫັດມັນບໍ່ເທົ່າກັນ";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          comboboxcontainer(context),
          const SizedBox(height: 8),
          TextFormField(
              decoration: InputDecoration(
                hintText: "ເບີໂທລະສັບ",
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.phone_bluetooth_speaker_sharp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => tel = value.trim(),
              validator: (String? tel) {
                if (tel!.isEmpty) {
                  return "ກະລຸນາປ້ອນຂໍ້ມູນ";
                } else if (tel.length < 12) {
                  return "ໃສ່ຫມາຍໂທລະສັບໃຫ້ຖຶກຕ້ອງ";
                } else if (tel.length < 8) {
                  return "ໃສ່ໝາຍໂທລະສັບໃຫ້ຖຶກຕ້ອງ";
                }
                return null;
              }),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              hintText: "ວັນ ເດືອນ ປີ ເກີດ",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.text,
            onChanged: (value) => birthday = value.trim(),
            validator:
                RequiredValidator(errorText: "ກະລຸນາປ້ອນ ວັນ ເດືອນ ປີ ເກີດ"),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              hintText: "ທີ່ຢູ່",
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.home_filled),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => address = value.trim(),
            validator: RequiredValidator(errorText: "ກະລຸນາປ້ອນທີ່ຢູ່"),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: element.pink,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () async{
              setState(() async {
                await check();
              });
            },
            child: const Text(
              "ບັນທືກ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container comboboxcontainer(context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20, left: 15),
              child: dropdownButton(),
            )
          ],
        ));
  }

  DropdownButton<String> dropdownButton() {
    return DropdownButton(
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 35,
        ),
        borderRadius: BorderRadius.circular(10),
        value: position,
        isExpanded: true,
        underline: Container(),
        hint: const Padding(
          padding: EdgeInsets.only(left: 35),
          child: Text("ເລືອກຕຳເເໜ່່ງ"),
        ),
        // icon: const Icon(Icons.keyboard_arrow_down),
        items: EmployeeData.positoin
            .map((e) => DropdownMenuItem(
                value: e,
                child: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(e),
                )))
            .toList(),
        onChanged: (String? v) {
          setState(() {
            position = v!;
          });
        });
  }
}
