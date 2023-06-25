// // ignore_for_file: sized_box_for_whitespace, avoid_print, non_constant_identifier_names, avoid_unnecessary_containers, prefer_if_null_operators, depend_on_referenced_packages

// import 'dart:math';
// import 'package:intl/intl.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// import '../WidgetSearch/widgetSearch.dart';
// import '../api/getCategoryData.dart';
// import '../api/getProduct.dart';
// import '../celement/elements.dart';
// import '../notifire/Cartnotififire.dart';
// import '../notifire/categoryNotifire.dart';
// import '../notifire/productNotifire.dart';
// import '../screen/menu.dart';


// class ViweProducts_Addmin extends StatefulWidget {
//   const ViweProducts_Addmin({Key? key}) : super(key: key);

//   @override
//   State<ViweProducts_Addmin> createState() => _ViweProducts_AddminState();
// }

// class _ViweProducts_AddminState extends State<ViweProducts_Addmin> {
//   bool colortype = false;
//   void colortypes() {
//     setState(() {
//       colortype;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     dos();
//     Productfacing();
//   }

//   Future dos() async {
//     ProductNotifire Pro = Provider.of<ProductNotifire>(context, listen: false);
//     await GetProduct(Pro);
//   }

//   Future Productfacing() async {
//     CategoryNotifire category =
//         Provider.of<CategoryNotifire>(context, listen: false);
//     await GetCategoryData(category);
//   }

//   @override
//   Widget build(BuildContext context) {
//     ProductNotifire product = Provider.of<ProductNotifire>(context);
//     CategoryNotifire category = Provider.of<CategoryNotifire>(context);
//     Cartnotifire cartno = Provider.of<Cartnotifire>(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: element.pink,
//         centerTitle: true,
//         title: const Text(
//           'ສັ່ງຊື້ສິນຄ້າເຂົ້າຮ້ານ',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         bottom: WidgetSearch(label: "ຄົ້ນຫາຂໍ້ມູນສິນຄ້າ",type: 'product',notifire: product),
//         leading: element().RoutePageBack(context, const Menu()),
//         // actions: [element.CartButton(context,route.Cart)],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ViewCategoryAll(product),
//             ViewCategory(category, product),
//             ViewProducts(context, product, cartno),
//           ],
//         ),
//       ),
//     );
//   }
// ///////////////////////////////////////////////////////////////////////
//   Padding ViewCategoryAll(ProductNotifire product) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 260),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//         decoration: BoxDecoration(
//             color: colortype == true ? element.pink : Colors.blue,
//             borderRadius: BorderRadius.circular(10)),
//         child: Row(
//           children: [
//             InkWell(
//               child: Text(
//                 'ສີນຄ້າທັ້ງໝົດ',
//                 style: TextStyle(color: element.wht),
//               ),
//               onTap: () {
//                 GetProduct(product);
//                 colortypes();
//                 colortype = true;
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// ///////////////////////////////////////////////////////////////////////  ////////////////////////////////
//   Container ViewCategory(CategoryNotifire category, ProductNotifire product) {
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.all(8),
//         itemCount: category.categoryList.length,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               GetProduct_type(product, category.categoryList[index].id, index);
//               colortype = false;
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//               margin: const EdgeInsets.symmetric(horizontal: 5),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: colortype != true ? element.pink : Colors.blue),
//               child: Row(
//                 children: [
//                   Container(
//                       child: Text('${category.categoryList[index].category}',
//                           style: TextStyle(color: element.wht))),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//   Container ViewProducts(
//       BuildContext context, ProductNotifire product, Cartnotifire cartno) {
//     return Container(
//       height: MediaQuery.of(context).size.height / 1.25,
//       child: GridView.builder(
//           padding: const EdgeInsets.all(10),
//           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 300,
//               childAspectRatio: 3 / 4.5,
//               crossAxisSpacing: 8,
//               mainAxisSpacing: 8),
//           itemCount: product.Products.length,
//           itemBuilder: (BuildContext ctx, index) {
//             return Content(product, index, cartno);
//           }),
//     );
//   }
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//   Widget Content(ProductNotifire product, int index, Cartnotifire cartno) {
//     return Container(
//         child: Card(
//       elevation: 14,
//       clipBehavior: Clip.antiAlias,
//       shadowColor: Colors.blue,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8.0))),
//       child: InkWell(
//         onTap: () {
//           product.CurrentProduct = product.Products[index];
//           product.getCurrentProduct();
//           cartno.Procartcart = product.Products[index];
//           Dailog(cartno, context);
//         },
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 8,
//             ),
//             Expanded(
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       '${product.Products[index].image != null ? product.Products[index].image : element.nullimage}',
//                       width: 150,
//                       height: 150,
//                       fit: BoxFit.fill,
//                     ))),
//             ListTile(
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'ຊື່: ${product.Products[index].nameProduct}',
//                     style: const TextStyle(color: Colors.black, fontSize: 18),
//                   ),
//                   Divider(
//                     color: Colors
//                         .primaries[Random().nextInt(Colors.primaries.length)],
//                     thickness: 1,
//                   ),
//                 ],
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('ລາຄາ:  '),
//                       Text(
//                           '${NumberFormat.decimalPattern().format(product.Products[index].price)}  ກີບ'),
//                     ],
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('ຈຳນວນ:  '),
//                       Text('${product.Products[index].amount}' '  ເເກັດ',
//                           style: TextStyle(
//                               color: product.Products[index].amount! <= 9
//                                   ? Colors.red
//                                   : const Color(0xff0FAA4D))),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }

// ////////////////////////////////////////////ADD TO CART /////////////////////////////////////////////////////////////////////////////

// Dailog(Cartnotifire Carts, context) {
//   return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.indeterminate_check_box_outlined,color: Colors.red,size: 30),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               Column(
//                 children: [
//                   Image.network('${Carts.Procartcart!.image}',
//                       fit: BoxFit.fitHeight),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                             'ຊື່ສິນຄ້າ: ' ' ${Carts.Procartcart!.nameProduct}'),
//                         Text('ຈຳນວນສິນຄ້າ: '
//                             ' ${Carts.Procartcart!.amount}'
//                             ' ແກັດ'),
//                         Text('ລາຄາ:'
//                             ' ${NumberFormat.decimalPattern().format(Carts.Procartcart!.price)}'
//                             ' ກີບ'),
//                         Text('ລາຍລະອຽດ:' ' ${Carts.Procartcart!.description}'),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     margin: const EdgeInsets.only(right: 15, left: 15),
//                     width: 390,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           primary: element.pink,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 16)),
//                       onPressed: () {
//                         Carts.cecks();
//                         Navigator.pop(context);
//                       },//r
//                       child: const Text(
//                         "ເພີ່ມສິນເຂົ້າກະຕ້າ",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               )
//             ],
//           ));
// }
