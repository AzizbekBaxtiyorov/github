import 'package:flutter/material.dart';
import 'package:flutter_modul_2/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({required this.recentTransaction, Key? key}) : super(key: key);

  final List<Transaction> recentTransaction;

  List<WeekTransaction> get groupedTransactions {
    return List.generate(7, (index) {
      final date = DateTime.now().subtract(Duration(days: index));
      final week = date.weekday;
      var totalDaily = 0.0;
      var total = 0.0;
      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.weekday == week) {
          totalDaily += recentTransaction[i].amount;
        }
        total += recentTransaction[i].amount;
      }
      return WeekTransaction(
          weekDay: DateFormat.E().format(date),
          amount: totalDaily,
          totalOfPrc: total == 0 ? 0.0 : totalDaily / total);
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isLandscape = media.orientation == Orientation.landscape;
    return LayoutBuilder(builder: (context, constraints) {
      print("chart height is ${constraints.maxHeight}");
      return Card(
        margin: EdgeInsets.only(
            left: 20,
            top: constraints.maxHeight * 0.1,
            right: 20,
            bottom: constraints.maxHeight * 0.08),
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.all(constraints.maxHeight * 0.05),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: groupedTransactions.map((element) {
              return Expanded(
                child: Column(
                  children: [
                    FittedBox(
                        child: Text(
                      "\$${element.amount.toInt()}",
                    )),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: 15,
                      height: isLandscape
                          ? constraints.maxHeight * 0.5
                          : constraints.maxHeight * 0.43,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(
                          //   color: Colors.purple,
                          // ),
                          color: const Color.fromRGBO(220, 220, 220, 1)),
                      child: FractionallySizedBox(
                        alignment: Alignment.bottomCenter,
                        heightFactor: element.totalOfPrc,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Text(element.weekDay),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}

class WeekTransaction {
  String weekDay;
  double amount;
  double totalOfPrc;

  WeekTransaction({
    required this.weekDay,
    required this.amount,
    required this.totalOfPrc,
  });
}
