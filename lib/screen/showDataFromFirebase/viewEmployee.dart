// ignore_for_file: non_constant_identifier_names, prefer_adjacent_string_concatenation, prefer_const_constructors



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/dialog_edit/dialog_and_snackbar.dart';

import '../../WidgetSearch/widgetSearch.dart';
import '../../api/getEmployeeData.dart';
import '../../celement/elements.dart';
import '../../notifire/employeeNotifire.dart';
import '../detialOfdata/employeeDetail.dart';
import '../product_add/registerEmployee.dart';

class ViewEmployee extends StatefulWidget {
  const ViewEmployee({Key? key}) : super(key: key);

  @override
  State<ViewEmployee> createState() => _ViewEmployeeState();
}

class _ViewEmployeeState extends State<ViewEmployee> {
  @override
  void initState() {
    super.initState();
    dos();
  }

  Future dos() async {
    EmployeeNotifire emp =
        Provider.of<EmployeeNotifire>(context, listen: false);
    await GetEmployeeData(emp);
  }

  @override
  Widget build(BuildContext context) {
    EmployeeNotifire emp = Provider.of<EmployeeNotifire>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: element.pink,
        centerTitle: true,
        title: const Text(
          'ຂໍ້ມູນຂອງພະນັກງານແຕ່ລະຄົນ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: WidgetSearch(label: "ຄົ້ນຫາຂໍ້ມູນພະນັກງານ",notifire: emp,type: 'emp'),
        leading: element().RoutePageBack(context, const EmployeeTapbar()),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return CardEmployee(index, emp);
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.black,
            );
          },
          itemCount: emp.employeeList.length),
    );
  }

  Widget CardEmployee(int index, EmployeeNotifire employee) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderOnForeground: true,
      elevation: 5,
      child: InkWell(
        child: ListTile(
          leading: const Icon(
            Icons.people,
            size: 30,
            color: Colors.black,
          ),
          title: Row(
            children: [
              const Text(
                'ຊື່:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(' ${employee.employeeList[index].name}'),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ຕຳແໜ່ງ: ${employee.employeeList[index].position}'),
              Text('ອີເມວ: ${employee.employeeList[index].email}')
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              employee.CurrentEmployee = employee.employeeList[index];
              Dialog_D(context, name: employee.CurrentEmployee!.name, typefuction: 'employee',notifire: employee);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
        onTap: () {
          employee.CurrentEmployee = employee.employeeList[index];
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const EmployeeDetail()));
        },
      ),
    );
  }
}
