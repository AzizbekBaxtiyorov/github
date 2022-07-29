import 'package:flutter/material.dart';
import 'package:flutter_modul_2/transaction.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {required this.transaction,
      required this.index,
      this.onDelete,
      required this.isDeletable,
      Key? key})
      :assert(isDeletable == true && onDelete != null || isDeletable == false),
       super(key: key);

  final Transaction transaction;
  final int index;
  final void Function(int index)? onDelete;
  final bool isDeletable;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: FittedBox(
                  child: Text(
                    "\$${transaction.amount.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    DateFormat.yMMMEd().format(transaction.date),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            isDeletable ? IconButton(
              onPressed: () => onDelete!(index),
              icon: const Icon(Icons.delete, color: Colors.red),
            ) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
