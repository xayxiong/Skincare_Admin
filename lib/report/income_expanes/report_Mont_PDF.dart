// ignore_for_file: non_constant_identifier_names, await_only_futures, avoid_print, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, camel_case_types, depend_on_referenced_packages

import 'dart:math';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:intl/intl.dart';

import '../../notifire/Repport_Notifire.dart';

class report_mont_PDF {
  static Save_income_Mont_PDF(report_incomeNotifire Mont, contex) async {
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
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text(
                  'ລາຍງານລາຍຮັບປະຈຳປີ : ${DateTime.now().year}',
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
                              'ວັນທີເດືອນປີ: ${DateTime.now()}',
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf),
                            ),
                          ]),
                    ]),
                pw.SizedBox(height: 40),
                pw.Center(
                  child: pw.Text(
                    'ລາຍລະອຽດ ລາຍຮັບ ຮ້ານຂາຍເຄື່ອງສຳອາງອອນລາຍ',
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Divider(),
                Subtitle_Purchase_Order_Detail(ttf),
                pw.Divider(),
                listView(Mont, ttf),
                pw.Divider(),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Text(
                          'ລວມເງີນທັ້ງໝົດ :  ${NumberFormat.decimalPattern().format(Mont.Sumtotal)} ກິບ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf)),
                    ])
              ],
            ),
          );
        },
      ),
    );

    int randomNumber = Random().nextInt(90) + 10000;
    final File file =
        await File('/storage/emulated/0/Download/$randomNumber.pdf');
    print(file);
    await file.writeAsBytes(await pdf.save()).then((value) {
      OpenFile.open('${file.path}');
    });
  }

  static pw.ListView listView(report_incomeNotifire Mont, pw.Font ttf) {
    return pw.ListView.builder(
      itemCount: Mont.icome.length,
      itemBuilder: (context, index) {
        return pw.Column(children: [
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(
                  width: 30,
                  child: pw.Text(
                    '${index + 1}',
                    style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf),
                  ),
                ),
                pw.SizedBox(
                  width: 60,
                  child: pw.Text(
                    'ເດືອນທີ່: ${Mont.icome[index].date!.toDate().toString().substring(6, 7)}',
                    style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf),
                  ),
                ),
                pw.SizedBox(
                  width: 60,
                  child: pw.Text(
                    '${NumberFormat.decimalPattern().format(Mont.icome[index].sumtatall)}',
                    style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf),
                  ),
                ),
              ])
        ]);
      },
    );
  }

  static pw.Row Subtitle_Purchase_Order_Detail(pw.Font ttf) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 30,
          child: pw.Text('ລຳດັບ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 60,
          child: pw.Text('ເດືອນ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 60,
          child: pw.Text('ລາຍຮັບ', style: pw.TextStyle(font: ttf)),
        ),
      ],
    );
  }
}

class report_Day_PDF {
  static Save_income_Day_PDF(report_incomeNotifire Day, contex) async {
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
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text(
                  'ລາຍງານລາຍຮັບປະຈຳເດືອນ: ${Day.icome_day[0].date!.toDate().toString().substring(0, 7)}',
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
                              'ວັນທີເດືອນປີ: ${DateTime.now()}',
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf),
                            ),
                          ]),
                    ]),
                pw.SizedBox(height: 40),
                pw.Center(
                  child: pw.Text(
                    'ລາຍລະອຽດ ລາຍຮັບປະຈຳເດືອນ ຮ້ານຂາຍເຄື່ອງສຳອາງອອນລາຍ',
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Divider(),
                Subtitle_Purchase_Order_Detail(ttf),
                pw.Divider(),
                listView(Day, ttf),
                pw.Divider(),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Text(
                          'ລວມເງີນທັ້ງໝົດ :  ${NumberFormat.decimalPattern().format(Day.Sumtotal)} ກິບ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf)),
                    ])
              ],
            ),
          );
        },
      ),
    );

    int randomNumber = Random().nextInt(90) + 10000;
    final File file =
        await File('/storage/emulated/0/Download/$randomNumber.pdf');
    print(file);
    await file.writeAsBytes(await pdf.save()).then((value) {
      OpenFile.open('${file.path}');
    });
  }

  static pw.ListView listView(report_incomeNotifire Day, pw.Font ttf) {
    return pw.ListView.builder(
      itemCount: Day.icome_day.length,
      itemBuilder: (context, index) {
        return pw.Column(children: [
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(
                  width: 30,
                  child: pw.Text(
                    '${index + 1}',
                    style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf),
                  ),
                ),
                pw.SizedBox(
                  width: 60,
                  child: pw.Text(
                    '${Day.icome_day[index].date!.toDate().toString().substring(0, 10)}',
                    style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf),
                  ),
                ),
                pw.SizedBox(
                  width: 60,
                  child: pw.Text(
                    '${NumberFormat.decimalPattern().format(Day.icome_day[index].sumtatall)}',
                    style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf),
                  ),
                ),
              ])
        ]);
      },
    );
  }

  static pw.Row Subtitle_Purchase_Order_Detail(pw.Font ttf) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 30,
          child: pw.Text('ລຳດັບ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 60,
          child: pw.Text('ວັນທີ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 60,
          child: pw.Text('ລາຍຮັບ', style: pw.TextStyle(font: ttf)),
        ),
      ],
    );
  }
}
