// ignore_for_file: unused_local_variable, prefer_adjacent_string_concatenation



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../celement/elements.dart';
import '../../dialog_edit/dialog_employee.dart';
import '../../notifire/employeeNotifire.dart';
import '../showDataFromFirebase/viewEmployee.dart';

class EmployeeDetail extends StatefulWidget {
  const EmployeeDetail({Key? key}) : super(key: key);

  @override
  State<EmployeeDetail> createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> {
  @override
  Widget build(BuildContext context) {
    EmployeeNotifire employee = Provider.of<EmployeeNotifire>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("ຂໍ້ມູນລາຍລະອຽດຂອງແຕ່ລະຄົນ "),
        centerTitle: true,
        leading: element().RoutePageBack(context, const ViewEmployee()),
        backgroundColor: element.pink,
      ),
      body: Center(
        child: Container(
          height: 400,
          margin: const EdgeInsets.all(10),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'ວັນທີ:' +
                                ' ${employee.CurrentEmployee!.date!.toDate().toString().substring(0, 10)}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'ລະຫັດ:' + ' ${employee.CurrentEmployee!.id}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'ຊື່ :' + ' ${employee.CurrentEmployee!.name}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'ອີເມວ: ' + ' ${employee.CurrentEmployee!.email}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'ເບີໂທ: ' + ' ${employee.CurrentEmployee!.tel}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'ຕຳແໜ່ງ: ' + '${employee.CurrentEmployee!.position}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'ວັນເດືອນປີເກີດ: ' +
                            '${employee.CurrentEmployee!.birthday}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'ທີ່ຢູ່: ' + ' ${employee.CurrentEmployee!.address}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 70),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    EmployeeDialog().Dialog(context, employee);
                                  },
                                  child: const Text(
                                    'ແກ້ໄຂ',
                                    style: TextStyle(fontSize: 16),
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
