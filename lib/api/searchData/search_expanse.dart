
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/Report_Income_Modle.dart';
import '../../notifire/Repport_Notifire.dart';
import '../Getrepoert/get_reportl_income.dart';

Search_expase(report_incomeNotifire report,String ym)async{

  DateTime start = DateTime.parse('$ym-01');
  print(start);
  String g ='$ym';
  List<String>ends =[];
  ends = g.split('-');
  Timestamp end =Timestamp.fromDate(DateTime(int.parse(ends[0]),int.parse(ends[1])+1,0,23,59,59,999));
  List<Report> m1 = [];
  List<num> sumtotal = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<Timestamp> Month = [
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
  ];
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection("importproducts")
      .where('date', isGreaterThan: start)
      .where('date', isLessThanOrEqualTo: end)
      .get();
  m1.clear();
  rfn.docs.forEach((element) async {
    Timestamp g = element['date'];
    String m = g.toDate().toString().substring(6, 7);
      Report_Month(m: m, Month: Month, sumtotal: sumtotal, g: g, element: element);
  });
  int i = 0;
  for (var shan in Month) {
    if (Month[i] != Timestamp(1, 1)) {
      Report m5 = Report(
          sumtatall: int.parse(sumtotal[i].toString()), date: Month[i]);
      m1.add(m5);
      report.expanese = m1;
      report.Refresh();
    }
    i++;
  }

}

Search_expanse_day(report_incomeNotifire report,String ym)async{

  DateTime start = DateTime.parse('$ym');
  print(start);
  String g ='$ym';
  List<String>ends =[];
  ends = g.split('-');
  Timestamp end =Timestamp.fromDate(DateTime(int.parse(ends[0]),int.parse(ends[1]),int.parse(ends[2]),23,59,59,999));
  List<Report> m1 = [];
  List<num> sumtotal = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  List<Timestamp> Day = [
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
    Timestamp(1, 1),
  ];
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection("order")
      .where('date', isGreaterThan: start)
      .where('date', isLessThanOrEqualTo: end)
      .get();
  m1.clear();
  rfn.docs.forEach((element) async {
    Timestamp g = element['date'];
    List<String> m = g.toDate().toString().split('-');
    print(element.data());
    if (element['Staustus'] == 'ສຳເລັດ') {
      Report_Day(m: m[1], Day: Day, sumtotal: sumtotal, g: g, element: element);
    }
  });
  int i = 0;
  for (var shan in Day) {
    if (Day[i] != Timestamp(1, 1)) {
      Report m5 = Report(
          sumtatall: int.parse(sumtotal[i].toString()), date: Day[i]);
      m1.add(m5);
      report.expanese_day = m1;
      report.Refresh();
    }
    i++;
  }

}