import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modul_2/add_transaction.dart';
import 'package:flutter_modul_2/chart.dart';
import 'package:flutter_modul_2/empty_box.dart';
import 'package:flutter_modul_2/list_item.dart';
import 'package:flutter_modul_2/transaction.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final transactionList = <Transaction>[];

  var _showChart = false;

  void deleteTransaction(int index) {
    setState(() {
      showAcceptDialog(index);
    });
  }

  void showAcceptDialog(int index) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return getDeleteWidget(index);
        });
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return AddTransaction(
            onAddTransaction: addTransaction,
          );
        });
  }

  void addTransaction(Transaction tx) {
    transactionList.add(tx);
    setState(() {});
  }

  List<Transaction> get recentTx {
    return transactionList.where((element) {
      return element.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;
    var media = MediaQuery.of(context);
    final isLandscape = media.orientation == Orientation.landscape;
    return isIOS
        ? CupertinoPageScaffold(
            child: SafeArea(child: getBody(isLandscape, media)),
            navigationBar: getAppBar(isIOS),
          )
        : Scaffold(
            appBar: getAppBar(isIOS),
            floatingActionButton: Platform.isAndroid
                ? FloatingActionButton(
                    onPressed: () {
                      showBottomSheet();
                    },
                    child: const Icon(Icons.add),
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: getBody(isLandscape, media));
  }

  Widget getBody(bool isLandscape, MediaQueryData media) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: media.size.height -
            media.viewPadding.top -
            media.viewPadding.bottom,
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Show chart"),
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (isChecked) {
                        setState(() {
                          _showChart = isChecked;
                        });
                      }),
                ],
              ),
            if (!isLandscape) getChart(isLandscape, media),
            if (!isLandscape) getTransactionList(),
            if (isLandscape)
              _showChart ? getChart(isLandscape, media) : getTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget getChart(bool isLandscape, MediaQueryData media) {
    return SizedBox(
      height: isLandscape ? media.size.height * 0.5 : media.size.height * 0.2,
      child: Chart(
        recentTransaction: recentTx,
      ),
    );
  }

  Widget getTransactionList() {
    return transactionList.isEmpty
        ? const Expanded(child: EmptyBox())
        : Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListItem(
                  transaction: transactionList[index],
                  index: index,
                  onDelete: deleteTransaction,
                  isDeletable: true,
                );
              },
              itemCount: transactionList.length,
            ),
          );
  }

  Widget getDeleteWidget(int index) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 80),
        child: Column(
          children: [
            const Text(
              "Are you sure?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ListItem(
              transaction: transactionList[index],
              index: index,
              isDeletable: false,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      transactionList.removeAt(index);
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text("Ha"),
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yo'q"),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  getAppBar(bool isIOS) {
    return isIOS
        ? CupertinoNavigationBar(
            // leading: Text(
            //   "Personal Expanses",
            //   style: Theme.of(context)
            //       .textTheme
            //       .headlineSmall
            //       ?.copyWith(color: Colors.black),
            // ),
            middle: Text(
              "Personal Expanses",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.black),
            ),
            trailing: GestureDetector(
                onTap: (() => showBottomSheet()),
                child: const Icon(CupertinoIcons.add)),
          )
        : AppBar(
            title: Text(
              "Personal Expanses",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: (() {
                  showBottomSheet();
                }),
                icon: const Icon(Icons.add),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          );
  }
}
