// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/Report_Income_Modle.dart';
import '../../notifire/Repport_Notifire.dart';


Get_reportl_income(report_incomeNotifire imcome) async {
  imcome.Sumtotal =0;
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
      .collection("order")
      .where('date', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, 1))
      .get();
  m1.clear();
  rfn.docs.forEach((element) async {
    Timestamp g = element['date'];
    String m = g.toDate().toString().substring(6, 7);
    print(element.data().length);
    print(m);
    if (element['Staustus'] == 'ສຳເລັດ') {
      Report_Month(
          m: m, Month: Month, sumtotal: sumtotal, g: g, element: element);
    }
  });
  int i = 0;
  for (var shan in Month) {
    if (Month[i] != Timestamp(1, 1)) {
      Report m5 = Report(sumtatall: int.parse(sumtotal[i].toString()), date: Month[i]);
      imcome.Sumtotal+=m5.sumtatall!.toInt();
      m1.add(m5);
      imcome.icome = m1;
      imcome.Refresh();
    }
    i++;
  }
}

Report_Month(
    {required String? m,
    required List<Timestamp>? Month,
    required List<num>? sumtotal,
    required Timestamp? g,
    required element}) {
  switch (m) {
    case '12':
      Month![11] = g!;
      sumtotal![11] += element['sumtotal'];
      break;
    case '11':
      Month![10] = g!;
      sumtotal![10] += element['sumtotal'];
      break;
    case '10':
      Month![9] = g!;
      sumtotal![9] += element['sumtotal'];
      break;
    case '9':
      Month![8] = g!;
      sumtotal![8] += element['sumtotal'];
      break;
    case '8':
      Month![7] = g!;
      sumtotal![7] += element['sumtotal'];
      break;
    case '7':
      Month![6] = g!;
      sumtotal![6] += element['sumtotal'];
      break;
    case '6':
      {
        Month![5] = g!;
        sumtotal![5] += element['sumtotal'];
      }
      break;
    case '5':
      Month![4] = g!;
      sumtotal![4] += element['sumtotal'];
      break;
    case '4':
      {
        Month![3] = g!;
        sumtotal![3] += element['sumtotal'];
      }
      break;
    case '3':
      {
        Month![2] = g!;
        sumtotal![2] += element['sumtotal'];
      }
      break;
    case '2':
      {
        Month![1] = g!;
        sumtotal![1] += element['sumtotal'];
        print(sumtotal[1]);
      }
      break;
    case '1':
      {
        Month![0] = g!;
        sumtotal![0] += element['sumtotal'];
      }
  }
}

Get_reportl_income_Month(report_incomeNotifire imcome) async {
  imcome.Sumtotal=0;
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
  List<String> year_M_D =
      imcome.curren_income!.date!.toDate().toString().split('-');
  DateTime stars = DateTime(
    int.parse(year_M_D[0]),
    int.parse(year_M_D[1]),
  );
  Timestamp? end = imcome.curren_income!.date;
  QuerySnapshot<Map<String, dynamic>> rfn = await FirebaseFirestore.instance
      .collection("order")
      .where('date', isGreaterThan: stars)
      .where('date', isLessThanOrEqualTo: end)
      .get();
  m1.clear();
  rfn.docs.forEach((element) async {
    Timestamp g = element['date'];
    //print('${g.toDate()}');
    String m = g.toDate().toString().substring(8, 10);

    if (element['Staustus'] == 'ສຳເລັດ') {
      print('${m}');
      Report_Day(m: m, Day: Day, sumtotal: sumtotal, g: g, element: element);
    }
  });
  int i = 0;
  for (var shan in Day) {
    if (Day[i] != Timestamp(1, 1)) {
      Report m5 =
          Report(sumtatall: int.parse(sumtotal[i].toString()), date: Day[i]);
      m1.add(m5);
      imcome.Sumtotal+=m5.sumtatall!.toInt();
      imcome.icome_day = m1;
      imcome.Refresh();
    }
    i++;
  }
}

Report_Day(
    {required String? m,
    required List<Timestamp>? Day,
    required List<num>? sumtotal,
    required Timestamp? g,
    required element}) async {
  switch (m) {
    case '31':
      Day![30] = g!;
      sumtotal![30] += element['sumtotal'];
      break;
    case '30':
      Day![29] = g!;
      sumtotal![29] += element['sumtotal'];
      break;
    case '29':
      Day![28] = g!;
      sumtotal![28] += element['sumtotal'];
      break;
    case '28':
      Day![27] = g!;
      sumtotal![27] += element['sumtotal'];
      break;
    case '27':
      Day![26] = g!;
      sumtotal![26] += element['sumtotal'];
      break;
    case '26':
      Day![25] = g!;
      sumtotal![25] += element['sumtotal'];
      break;
    case '25':
      Day![24] = g!;
      sumtotal![24] += element['sumtotal'];
      break;
    case '24':
      Day![23] = g!;
      sumtotal![23] += element['sumtotal'];
      break;
    case '23':
      Day![22] = g!;
      sumtotal![22] += element['sumtotal'];
      break;
    case '22':
      Day![21] = g!;
      sumtotal![21] += element['sumtotal'];
      break;
    case '21':
      Day![20] = g!;
      sumtotal![20] += element['sumtotal'];
      break;
    case '20':
      Day![19] = g!;
      sumtotal![19] += element['sumtotal'];
      break;
    case '19':
      Day![18] = g!;
      sumtotal![18] += element['sumtotal'];
      break;
    case '18':
      Day![17] = g!;
      sumtotal![17] += element['sumtotal'];
      break;
    case '17':
      Day![16] = g!;
      sumtotal![16] += element['sumtotal'];
      break;
    case '16':
      Day![15] = g!;
      sumtotal![15] += element['sumtotal'];
      break;
    case '15':
      Day![14] = g!;
      sumtotal![14] += element['sumtotal'];
      break;
    case '14':
      Day![13] = g!;
      sumtotal![13] += element['sumtotal'];
      break;
    case '13':
      Day![12] = g!;
      sumtotal![12] += element['sumtotal'];
      break;
    case '12':
      Day![11] = g!;
      sumtotal![11] += element['sumtotal'];
      break;
    case '11':
      Day![10] = g!;
      sumtotal![10] += element['sumtotal'];
      break;
    case '10':
      Day![9] = g!;
      sumtotal![9] += element['sumtotal'];
      break;
    case '09':
      Day![8] = g!;
      sumtotal![8] += element['sumtotal'];
      break;
    case '08':
      Day![7] = g!;
      sumtotal![7] += element['sumtotal'];
      break;
    case '07':
      Day![6] = g!;
      sumtotal![6] += element['sumtotal'];
      break;
    case '06':
      {
        Day![5] = g!;
        sumtotal![5] += element['sumtotal'];
      }
      break;
    case '05':
      Day![4] = g!;
      sumtotal![4] += element['sumtotal'];
      break;
    case '04':
      {
        Day![3] = g!;
        sumtotal![3] += element['sumtotal'];
      }
      break;
    case '03':
      {
        Day![2] = g!;
        sumtotal![2] += element['sumtotal'];
      }
      break;
    case '02':
      {
        Day![1] = g!;
        sumtotal![1] += element['sumtotal'];
      }
      break;
    case '01':
      {
        Day![0] = g!;
        sumtotal![0] += element['sumtotal'];
      }
      break;
  }
  ;
}
