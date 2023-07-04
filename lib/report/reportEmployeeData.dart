// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/report/buttonReportData.dart';
import 'package:skin_care/report/reportEmployeeDataToPDF.dart';

import '../celement/elements.dart';

import '../notifire/employeeNotifire.dart';

class ReportEmployeeData extends StatefulWidget {
  const ReportEmployeeData({Key? key}) : super(key: key);

  @override
  State<ReportEmployeeData> createState() => _ReportEmployeeDataState();
}

class _ReportEmployeeDataState extends State<ReportEmployeeData> {
  @override
  Widget build(BuildContext context) {
    EmployeeNotifire emp = Provider.of<EmployeeNotifire>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('ລາຍງານຂໍ້ມູນພະນັກງານ'),
          centerTitle: true,
          backgroundColor: element.pink,
          leading: element().RoutePageBack(context, const ReportData()),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Text('ພະນັກງານທັງໝົດມີ ${emp.employeeList.length} ຄົນ',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: emp.employeeList.length,
                itemBuilder: (BuildContext context, int index) {
                  //   emp.CheckPosition(emp.employeeList[index].position.toString(),emp);
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'ຊື່ພະນັກງານ: ${emp.employeeList[index].name}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            'ຕຳແຫນ່ງ: ${emp.employeeList[index].position}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'ເບີໂທ: ${emp.employeeList[index].tel}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'ອີເມວ: ${emp.employeeList[index].email}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'ທີ່ຢູ່: ${emp.employeeList[index].address}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Addmin ມີ ${emp.addminCount} ຄົນ',
                    style: const TextStyle(fontSize: 17)),
               
              ],
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              width: double.maxFinite,
              height: 55,
              child: ElevatedButton(
                  onPressed: () async {
                    EmployeePDF.SaveEmployeePDF(emp, context);
                  },
                  child: const Text(
                    'ພິມລາຍງານ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )),
            ),
            const SizedBox(height: 50)
          ],
        ));
  }
}
