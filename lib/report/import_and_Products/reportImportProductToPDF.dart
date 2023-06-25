// ignore_for_file: non_constant_identifier_names, await_only_futures, avoid_print, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, camel_case_types, depend_on_referenced_packages

import 'dart:math';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

import 'package:intl/intl.dart';

import '../../notifire/supplierNotifire.dart';

class ImportProductPDF {
  static SaveImportProductPDF(SupplierNotifire importProduct, context) async {
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
                  'ລາຍງານການນຳເຂົ້າຂໍ້ມູນສິນຄ້າ',
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
                pw.Text(
                  'ຮ້ານຂາຍເຄື່ອງສຳອາງອອນລາຍ',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'ຊື່ຜູ້ສົ່ງ: ${importProduct.CurrentSupplier!.name}',
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf),
                            ),
                            pw.Text(
                              'ເບີໂທ: ${importProduct.CurrentSupplier!.tel}',
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf),
                            ),
                            pw.Row(children: [
                              pw.Text('ອີເມວ:',
                                  style: pw.TextStyle(font: ttf, fontSize: 12)),
                              pw.Text(
                                ' ${importProduct.CurrentSupplier!.email}',
                                style: const pw.TextStyle(fontSize: 12),
                              ),
                            ]),
                            pw.Text(
                                'ສິນຄ້າທັງໝົດມີ: ${importProduct.Product.length} ລາຍການ',
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf)),
                            pw.Text(
                                'ຈຳນວນສິນຄ້າທັງໝົດ: ${importProduct.countket} ອັນ',
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf)),
                            pw.Text(
                                'ລາຄາລວມທັງໝົດ: ${NumberFormat.decimalPattern().format(importProduct.sumtotal)} ກີບ',
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf)),
                          ]),
                    ]),
                pw.SizedBox(height: 20),
                pw.Center(
                  child: pw.Text(
                    'ລາຍລະອຽດຂອງການນຳເຂົ້າຂໍ້ມູນສິນຄ້າ',
                    style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Divider(),
                Subtitle_Purchase_Order_Detail(ttf),
                pw.Divider(),
                pw.ListView.builder(
                  itemCount: importProduct.Product.length,
                  itemBuilder: (context, index) {
                    return pw.Column(children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(
                              width: 90,
                              child: pw.Text(
                                '${index + 1}',
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf),
                              ),
                            ),
                            pw.SizedBox(
                              width: 100,
                              child: pw.Text(
                                '${importProduct.Product[index].nameProduct}',
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf),
                              ),
                            ),
                            pw.SizedBox(
                              width: 100,
                              child: pw.Text(
                                '${importProduct.Product[index].amount} ອັນ',
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf),
                              ),
                            ),
                            pw.SizedBox(
                              width: 100,
                              child: pw.Text(
                                '${importProduct.Product[index].category_id}',
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf),
                              ),
                            ),
                            pw.Row(children: [
                              pw.SizedBox(
                                  width: 100,
                                  child: pw.Row(children: [
                                    pw.Text(
                                      NumberFormat.decimalPattern().format(
                                          importProduct.Product[index].price),
                                      style: pw.TextStyle(
                                          fontSize: 14,
                                          fontWeight: pw.FontWeight.bold,
                                          font: ttf),
                                    ),
                                    pw.Text(
                                      ' ກີບ',
                                      style: pw.TextStyle(
                                          fontSize: 14,
                                          fontWeight: pw.FontWeight.bold,
                                          font: ttf),
                                    ),
                                  ])),
                            ])
                          ])
                    ]);
                  },
                ),
                pw.Divider(),
              ],
            ),
          );
        },
      ),
    );

    int randomNumber = Random().nextInt(90) + 10;
    String date =
        await importProduct.CurrentSupplier!.date!.toDate().toString();
    String result = date.substring(2, 11);
    print(result);
    final File file =
        await File('/storage/emulated/0/Download/$randomNumber$result.pdf');
    print(file);
    await file.writeAsBytes(await pdf.save()).then((value) {
      OpenFile.open('${file.path}');
    });
  }

  static pw.Row Subtitle_Purchase_Order_Detail(pw.Font ttf) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 90,
          child: pw.Text('ລຳດັບ', style: pw.TextStyle(font: ttf, fontSize: 14)),
        ),
        pw.Container(
          width: 100,
          child: pw.Text('ຊື່', style: pw.TextStyle(font: ttf, fontSize: 14)),
        ),
        pw.Container(
          width: 100,
          child: pw.Text('ຈຳນວນ', style: pw.TextStyle(font: ttf, fontSize: 14)),
        ),
        pw.Container(
          width: 100,
          child: pw.Text('ປະເພດ', style: pw.TextStyle(font: ttf, fontSize: 14)),
        ),
        pw.Container(
          width: 100,
          child: pw.Text('ລາຄາ', style: pw.TextStyle(font: ttf, fontSize: 14)),
        ),
      ],
    );
  }
}
