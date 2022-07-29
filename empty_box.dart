import 'package:flutter/material.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return LayoutBuilder(
      builder: ((ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: isLandscape
            //       ? constraints.maxHeight * 0.1
            //       : constraints.maxHeight * 0.1,
            // ),
            Image.asset(
              "assets/images/icon_empty.png",
              height: isLandscape
                  ? constraints.maxHeight * 0.4
                  : constraints.maxHeight * 0.3,
            ),
            const SizedBox(
              height: 20,
            ),
            Text("No Transaction!",
                style: Theme.of(context).textTheme.titleMedium),
          ],
        );
      }),
    );
  }
}
