// ignore_for_file: non_constant_identifier_names, must_call_super

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../api/aip.dart';
import '../../celement/elements.dart';
import '../../dialog_edit/dialog_and_snackbar.dart';
import '../../model/supplier_data.dart';
import '../../notifire/supplierNotifire.dart';
import '../menu.dart';
import '../showDataFromFirebase/viewSupplier.dart';

class SupplierTapbar extends StatefulWidget {
  const SupplierTapbar({Key? key}) : super(key: key);

  @override
  State<SupplierTapbar> createState() => _SupplierTapbarState();
}

class _SupplierTapbarState extends State<SupplierTapbar> {
  @override
  Widget build(BuildContext context) {
    return element().TabbarPage(
        label1: 'ເພີ່ມຜູ້ສະໜອງ',
        icos1: Icons.ad_units,
        icos2: Icons.feed,
        label2: 'ຂໍ້ມູນຜູ້ສະໜອງ',
        tap1: const Supplier(),
        tap2: const ViewSupplier());
  }
}

class Supplier extends StatefulWidget {
  const Supplier({Key? key}) : super(key: key);

  @override
  State<Supplier> createState() => _SupplierState();
}

late GlobalKey<FormState> formKey = GlobalKey<FormState>();
final Future<FirebaseApp> firebase = Firebase.initializeApp();
SupplierData supplierData = SupplierData();

class _SupplierState extends State<Supplier> {
  String? names;
  String? emails;
  String? tels;
  String? address;
  String? supplyProducts;

  @override
  Widget build(BuildContext context) {
    SupplierNotifire Supp = Provider.of<SupplierNotifire>(context);
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
                title: const Text(' ລົງທະບຽນຜູ້ສະໜອງ'),
                centerTitle: true,
                backgroundColor: element.pink,
                leading: element().RoutePageBack(context, const Menu()),
              ),
              body: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _header(context),
                        const SizedBox(height: 40),
                        _inputFields(context, Supp),
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
        });
  }

  _header(context) {
    return Column(
      children: const [
        Text(
          "ລົງທະບຽນຜູ້ສະໜອງ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "ຮ້ານຂາຍເຄື່ອງສຳອາງອອນລາຍ",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  _inputFields(context, SupplierNotifire Supp) {
    return Form(
      key: formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
          onSaved: (String? name) {
            names = name;
          },
          validator: (String? name) {
            if (name!.isEmpty) {
              return "ກະລຸນາປ້ອນຊື່ ແລະ ນາມສະກຸນ";
            } else if (name.length < 6) {
              return "ຊື່ ແລະ ນາມສະກຸນມັນສັ້ນເກີນໄປ";
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
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
          onSaved: (String? email) {
            emails = email;
          },
          validator: MultiValidator(
            [
              RequiredValidator(errorText: "ກະລຸນາປ້ອນອີເມວ"),
              EmailValidator(errorText: "ຮູບແບບອີເມວບໍ່ຖືກຕ້ອງ"),
            ],
          ),
        ),
        const SizedBox(height: 10),
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
          onSaved: (String? tel) {
            tels = tel;
          },
          validator: (String? tel) {
            if (tel!.isEmpty) {
              return "ກະລຸນາປ້ອນຂໍ້ມູນ";
            } else if (tel.length < 12) {
              return "ໃສ່ຫມາຍໂທລະສັບໃຫ້ຖຶກຕ້ອງ";
            } else if (tel.length < 8) {
              return "ໃສ່ໝາຍໂທລະສັບໃຫ້ຖຶກຕ້ອງ";
            }
          },
        ),
        const SizedBox(height: 10),
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
          onSaved: (String? addres) {
            address = addres;
          },
          validator: RequiredValidator(errorText: "ກະລຸນາປ້ອນທີ່ຢູ່"),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            hintText: "ສິນຄ້າຜູ້ສະໜອງ",
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.production_quantity_limits),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          onSaved: (String? supplyProduct) {
            supplyProducts = supplyProduct;
          },
          validator:
              RequiredValidator(errorText: "ກະລຸນາປ້ອນສິນຄ້າຂອງຜູ້ສະໜອງ"),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: element.pink,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              Dialog_Cire(context);
              await AddSupplier(Supp,
                  address: address,
                  email: emails,
                  name: names,
                  tel: tels,
                  supplyProduct: supplyProducts);
              Navigator.pop(context);
              formKey.currentState!.reset();
              Fluttertoast.showToast(
                msg: "ເພີ່ມຂໍ້ມູນສຳເລັດ",
                fontSize: 20,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.white,
                textColor: Colors.black,
              );
            }
          },
          child: const Text(
            "ບັນທືກ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }
}
