// ignore_for_file: non_constant_identifier_names, await_only_futures, avoid_print, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, camel_case_types, depend_on_referenced_packages

import 'dart:math';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

import '../notifire/employeeNotifire.dart';


class EmployeePDF {
  static SaveEmployeePDF(EmployeeNotifire emp, context) async {
    final font = await rootBundle.load('lib/assets/Phetsarath-Regular.ttf');
    final pw.Font ttf = pw.Font.ttf(font);
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a3,
        build: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.all(10),
            child: pw.Column(
              children: [
                pw.Text(
                  'ລາຍງານຂໍ້ມູນພະນັກງານ',
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
                              'ພະນັກງານທັງໝົດມີ: ${emp.employeeList.length} ຄົນ',
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf),
                            ),
                            pw.Text(
                              'ແອັດມິນມີ: ${emp.addminCount} ຄົນ',
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
                    'ລາຍລະອຽດຂອງພະນັກງານ',
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
                pw.ListView.builder(
                  itemCount: emp.employeeList.length,
                  itemBuilder: (context, index) {
                    List<String> province = emp.employeeList[index].address
                        .toString()
                        .split('ແຂວງ');
                    return pw.Column(children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
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
                              width: 100,
                              child: pw.Text(
                                '${emp.employeeList[index].name}',
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf),
                              ),
                            ),
                            pw.SizedBox(
                              width: 60,
                              child: pw.Text(
                                '${emp.employeeList[index].id}',
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              width: 70,
                              child: pw.Text(
                                '${emp.employeeList[index].position}',
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              width: 120,
                              child: pw.Text(
                                '${emp.employeeList[index].tel}',
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf),
                              ),
                            ),
                            pw.SizedBox(
                              width: 120,
                              child: pw.Text(
                                '${emp.employeeList[index].email}',
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              width: 110,
                              child: pw.Text(
                                '${province[1].toString()}',
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf),
                              ),
                            )
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
    String date = await emp.CurrentEmployee_loco!.date!.toDate().toString();
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
          width: 30,
          child: pw.Text('ລຳດັບ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 100,
          child: pw.Text('ຊີ່', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 60,
          child: pw.Text('ລະຫັດ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 70,
          child: pw.Text('ຕຳແຫນ່ງ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 120,
          child: pw.Text('ເບີໂທ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 120,
          child: pw.Text('ອີເມວ', style: pw.TextStyle(font: ttf)),
        ),
        pw.Container(
          width: 110,
          child: pw.Text('ທີ່ຢູ່', style: pw.TextStyle(font: ttf)),
        ),
      ],
    );
  }
}
