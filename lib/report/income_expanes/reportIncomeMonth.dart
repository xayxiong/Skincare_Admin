// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/report/income_expanes/reportIncome.dart';


import '../../WidgetSearch/widgetSearch.dart';

import '../../celement/elements.dart';
import '../../notifire/Repport_Notifire.dart';
import 'package:intl/intl.dart';

import 'Button_prin.dart';

class ReportIncomeMonth extends StatefulWidget {
  const ReportIncomeMonth({Key? key}) : super(key: key);

  @override
  State<ReportIncomeMonth> createState() => _ReportIncomeMonthState();
}

final List items = List.generate(4, (i) => "Item $i");

class _ReportIncomeMonthState extends State<ReportIncomeMonth> {
  @override
  Widget build(BuildContext context) {
    report_incomeNotifire income = Provider.of<report_incomeNotifire>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('ລາຍງານລາຍຮັບປະຈຳວັນ'),
          centerTitle: true,
          backgroundColor: element.pink,
          leading: element().RoutePageBack(context, const ReportIncome()),
          bottom: WidgetSearch(
              label: 'ປີ - ເດືອນ -ວັນ', type: 'incomeM', notifire: income),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    ' ເດືອນ: ${income.curren_income!.date!.toDate().toString().substring(0, 7)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: income.icome_day.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(right: 10, left: 10),
                      child: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                        'ວັນທີ: ${income.icome_day[index].date!.toDate().toString().substring(0, 10)}'),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'ລາຍຮັບທັງໝົດ:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              ' ${NumberFormat.decimalPattern().format(income.icome_day[index].sumtatall)}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: element.pink,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              ' ກີບ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox();
                },
              ),
            ),
            SizedBox(height: 10),
            Button_prin(
              type: 'incomeDay',
              context: context,
              mont: income,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
