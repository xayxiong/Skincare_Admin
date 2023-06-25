// ignore_for_file: non_constant_identifier_names, await_only_futures, avoid_print, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'dart:math';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';

import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

import '../notifire/purchase_order_Notifire.dart';
import '../notifire/supplierNotifire.dart';

class Bill {
  static save_Bill(purchase_order_Notifire orderadmin, context,
      SupplierNotifire supp) async {
    final font = await rootBundle.load('lib/assets/Phetsarath-Regular.ttf');
    final pw.Font ttf = pw.Font.ttf(font);
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.all(10),
            child: pw.Column(
              children: [
                pw.Text(
                  'ຮ້ານຂາຍເຄື່ອງສຳອາງອອນລາຍ',
                  style: pw.TextStyle(
                      fontSize: 25, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
                pw.Text(
                  'ໃບສັ່ງຊື້ສິນຄ້າ',
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
                pw.SizedBox(height: 40),
                Subheader_Purchase_OrderDetial(ttf, supp, orderadmin),
                pw.SizedBox(height: 40),
                pw.Divider(),
                Subtitle_Purchase_Order_Detail(ttf),
                pw.Divider(),
                Detail_Purchase_Order(ttf, orderadmin),
                pw.Divider(),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 30),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text('ຈຳນວນລວມ: ',
                          style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 15)),
                      pw.Text('${orderadmin.Currenorderaddmin!.amouttotal}',
                          style: const pw.TextStyle(
                            fontSize: 15,
                          )),
                      pw.Text(' ອັນ ',
                          style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 15)),
                    ],
                  ),
                ),
                pw.Divider(),
                pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 0, top: 20),
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Text('ລາຍເຊັນ ອະນຸມັດ',
                              style: pw.TextStyle(
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 15)),
                          pw.Text('.........................................'),
                        ]))
              ],
            ),
          );
        },
      ),
    );

    int randomNumber = Random().nextInt(90) + 10;
    String date = await orderadmin.Currenorderaddmin!.date!.toDate().toString();
    String result = date.substring(2, 11);
    print(result);
    final File file = await File(
        '/storage/emulated/0/Download/$randomNumber${supp.CurrentSupplier!.name}$result.pdf');
    print(file);
    await file.writeAsBytes(await pdf.save()).then((value) {
      OpenFile.open('${file.path}');
    });
  }

  static pw.Row Subheader_Purchase_OrderDetial(
      pw.Font ttf, SupplierNotifire supp, purchase_order_Notifire orderadmin) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(children: [
                pw.Text(
                  'ລະຫັດ: ',
                  style: pw.TextStyle(font: ttf),
                ),
                pw.Text('${orderadmin.Currenorderaddmin!.id}'),
              ]),
              pw.Row(children: [
                pw.Text('ຊື່ຜູ້ສະໜອງ: ', style: pw.TextStyle(font: ttf)),
                pw.Text('${supp.CurrentSupplier!.name}',
                    style: pw.TextStyle(font: ttf)),
              ]),
              pw.Row(
                children: [
                  pw.Text(
                    'ເບີໂທ: ',
                    style: pw.TextStyle(font: ttf),
                  ),
                  pw.Text('${supp.CurrentSupplier!.tel}'),
                ],
              ),
              pw.Row(children: [
                pw.Text(
                  'ອີເມວ: ',
                  style: pw.TextStyle(font: ttf),
                ),
                pw.Text('${supp.CurrentSupplier!.email}'),
              ]),
              pw.Row(
                children: [
                  pw.Text(
                    'ທີ່ຢູ່: ',
                    style: pw.TextStyle(font: ttf),
                  ),
                  pw.Text('${supp.CurrentSupplier!.address}',
                      style: pw.TextStyle(font: ttf)),
                ],
              )
            ],
          ),
        ),
        pw.Text(
          'ວັນທີ ເດືອນ ປີ: ${orderadmin.Currenorderaddmin!.date!.toDate()}',
          style: pw.TextStyle(font: ttf),
        ),
      ],
    );
  }

  static pw.Row Subtitle_Purchase_Order_Detail(pw.Font ttf) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      children: [
        pw.Container(
          width: 70,
          child: pw.Text('ລຳດັບ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 70,
          child: pw.Text('ຊື່ສິນຄ້າ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 70,
          child: pw.Text('ປະເພດສິນຄ້າ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 70,
          child: pw.Text('ຈຳນວນ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 70,
          child: pw.Text('ຫົວໜ່ວຍ', style: pw.TextStyle(font: ttf)),
        ),
      ],
    );
  }

  static pw.ListView Detail_Purchase_Order(
      pw.Font ttf, purchase_order_Notifire orderadmin) {
    return pw.ListView.builder(
        itemBuilder: (
          context,
          index,
        ) {
          return pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              pw.SizedBox(height: 5),
              pw.Container(
                width: 70,
                child: pw.Text('${index + 1}', style: pw.TextStyle(font: ttf)),
              ),
              pw.Container(
                width: 70,
                child: pw.Text('${orderadmin.Productditill[index].nameProduct}',
                    style: pw.TextStyle(font: ttf)),
              ),
              pw.Container(
                width: 70,
                child: pw.Text(
                    '${orderadmin.Product_categoryname[index].category}',
                    style: pw.TextStyle(font: ttf)),
              ),
              pw.Container(
                  width: 70,
                  child: pw.Text(
                    '${orderadmin.Productditill[index].amount}',
                    style: pw.TextStyle(font: ttf),
                  )),
              pw.Container(
                width: 70,
                child: pw.Text('ອັນ', style: pw.TextStyle(font: ttf)),
              ),
            ],
          );
        },
        itemCount: orderadmin.Productditill.length);
  }
}
