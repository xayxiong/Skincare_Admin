// // ignore_for_file: non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:skin_care/celement/elements.dart';


// import '../api/UploadData/Get_Data_phuasOrder.dart';
// import '../api/getsupplier.dart';
// import '../dialog_edit/dialog_and_snackbar.dart';
// import '../notifire/Cartnotififire.dart';
// import '../notifire/supplierNotifire.dart';

// class Cart extends StatefulWidget {
//   const Cart({Key? key}) : super(key: key);

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   @override
//   void initState() {
//     super.initState();
//     dos();
//   }

//   Future dos() async {
//     SupplierNotifire supp =
//         Provider.of<SupplierNotifire>(context, listen: false);
//     await GetSupplier(supp);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Cartnotifire cart = Provider.of<Cartnotifire>(context);
//     SupplierNotifire supp = Provider.of<SupplierNotifire>(context);
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: cart.Cartlist.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Row(
//                               children: [
//                                 Image.network(
//                                   '${cart.Cartlist[index].Product!.image}',
//                                   width: 100,
//                                   height: 120,
//                                   fit: BoxFit.fitWidth,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                      mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                           'ຊື່:',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                             ' ${cart.Cartlist[index].Product!.nameProduct}'),
//                                       ],
//                                     ),
//                                     Text(
//                                         'ລາຄາ: ${cart.Cartlist[index].Product!.price} ກີບ')
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     TextButton(
//                                         onPressed: () {
//                                           cart.sum(index);
//                                         },
//                                         child: const Text('ເພີ່ມ')),
//                                     Text('${cart.Cartlist[index].amout}'),
//                                     TextButton(
//                                         onPressed: () {
//                                           cart.dedet(index);
//                                         },
//                                         child: const Text('ລົບ')),
//                                   ],
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     cart.remove(index);
//                                   },
//                                   icon: const Icon(Icons.delete),
//                                   color: Colors.red,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             height: 100,
//             width: 400,
//             decoration: const BoxDecoration(),
//             child: comboboxcontainer(context, supp, cart),
//           ),
//           Container(
//             margin: const EdgeInsets.only(right: 15, left: 15),
//             width: 390,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   primary: element.pink,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   padding: const EdgeInsets.symmetric(vertical: 16)),
//               onPressed: ()async{
//                 Dialog_Cire(context);
//                 await Upload_Data_phuashOrder(cart);
//                 Navigator.pop(context);
//                 await ShowMessage(type: true,text: 'ລາຍການສັ່ງຊື້');
//                 cart.Carts.clear();
//               //  cart.Cartlist.clear();
//                 cart.Refresh();

//               },
//               child: const Text(
//                 "ສັ່ງຊື້",
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }

// comboboxcontainer(context, SupplierNotifire supp, Cartnotifire cart) {
//   return Row(
//     children: [
//       Container(
//           width: 230,
//           height: 100,
//           margin: const EdgeInsets.only(top: 20),
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//           child: Column(
//             children: [
//               dropdownButton(supp, cart),
//             ],
//           )),
//       Padding(
//         padding: const EdgeInsets.only(bottom: 10, left: 55),
//         child: Text('ຈຳນວນ: ${cart.amoultoal} ແກັດ'),
//       )
//     ],
//   );
// }

// DropdownButton<String> dropdownButton(
//     SupplierNotifire supp, Cartnotifire cart) {
//   int index = 0;
//   return DropdownButton(
//       icon: const Icon(
//         Icons.keyboard_arrow_down,
//         size: 35,
//       ),
//       borderRadius: BorderRadius.circular(10),
//       value: supp.SuppType,
//       isExpanded: true,
//       underline: Container(),
//       hint: const Padding(
//         padding: EdgeInsets.only(left: 30),
//         child: Text("ເລືອກຜູ້ສະຫນອງ"),
//       ),
//       // icon: const Icon(Icons.keyboard_arrow_down),

//       items: supp.Suplierid.map((e) => DropdownMenuItem(
//             value: e,
//             child: Padding(
//               padding: const EdgeInsets.only(left:20.0),
//               child: Text('${supp.SuplierList[index++].name}'),
//             ),
//           )).toList(),
//       onChanged: (String? v) {
//         supp.SelectType(v);
//         cart.getCartsupp(v);
//       });
// }
