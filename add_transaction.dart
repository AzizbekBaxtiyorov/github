import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modul_2/transaction.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  AddTransaction({required this.onAddTransaction, Key? key}) : super(key: key);

  final Function onAddTransaction;
  DateTime? date;

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final nameController = TextEditingController();

  final amountController = TextEditingController();

  void showPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        widget.date = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            isIOS
                ? CupertinoTextField(
                    onSubmitted: (_) {
                      addTransaction();
                    },
                    controller: nameController,
                    prefix: const Text("Xarajatlar sababi"),
                    prefixMode: OverlayVisibilityMode.notEditing,
                  )
                : TextField(
                    decoration:
                        const InputDecoration(labelText: "Xarajatlar sababi."),
                    controller: nameController,
                    onSubmitted: (_) {
                      addTransaction();
                    },
                  ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: "Xarajat qiymati"),
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true, signed: true),
              onSubmitted: (_) {
                addTransaction();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.date != null
                    ? DateFormat("dd.MM.yyyy").format(widget.date!)
                    : "No date"),
                CupertinoButton(
                  onPressed: () {
                    showPicker();
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Choose date!",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: addTransaction,
              child: const Text("add transaction"),
            ),
          ],
        ),
      ),
    );
  }

  void addTransaction() {
    final tx = Transaction(
      id: DateTime.now().toString(),
      name: nameController.text,
      amount: double.parse(amountController.text),
      date: widget.date != null ? widget.date! : DateTime.now(),
    );
    widget.onAddTransaction(tx);
    Navigator.of(context).pop();
  }
}
