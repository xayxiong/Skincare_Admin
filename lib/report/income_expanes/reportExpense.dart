// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/report/income_expanes/reportExpenseMonth.dart';

import '../../WidgetSearch/widgetSearch.dart';
import '../../api/Getrepoert/get_report_Expanese.dart';
import '../../celement/elements.dart';
import 'package:intl/intl.dart';

import '../../notifire/Repport_Notifire.dart';
import '../buttonReportData.dart';
import 'Button_prin.dart';

class ReportExpense extends StatefulWidget {
  const ReportExpense({Key? key}) : super(key: key);

  @override
  State<ReportExpense> createState() => _ReportExpenseState();
}

final List items = List.generate(3, (i) => "Item $i");

class _ReportExpenseState extends State<ReportExpense> {
  @override
  Widget build(BuildContext context) {
    report_incomeNotifire Expanese =
        Provider.of<report_incomeNotifire>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ລາຍງານລາຍຈ່າຍປະຈຳເດືອນ'),
        centerTitle: true,
        backgroundColor: element.pink,
        leading: element().RoutePageBack(context, const ReportData()),
        bottom: WidgetSearch(
            label: 'ປີ - ເດືອນ/2000-01', type: 'exp', notifire: Expanese),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: Expanese.expanese.length,
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
                                      'ວັນທີ: ${Expanese.expanese[Expanese.expanese.length - index - 1].date!.toDate().toString().substring(0, 7)}'),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'ລາຍຈ່າຍທັງໝົດ:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                ' - ${NumberFormat.decimalPattern().format(Expanese.expanese[Expanese.expanese.length - index - 1].sumtatall)}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                ' ກີບ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            child: Icon(
                                                Icons.arrow_forward_ios_sharp,
                                                size: 14),
                                          )
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
                      onTap: () {
                        Expanese.curren_expanese = Expanese
                            .expanese[Expanese.expanese.length - index - 1];
                        Get_reportl_Expanese_day(Expanese);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ReportExpenseMonth()));
                      },
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox();
              },
            ),
          ),
          Button_prin(type: 'expanesMont', mont: Expanese, context: context),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
