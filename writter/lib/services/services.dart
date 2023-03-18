import 'package:flutter/material.dart';
import 'package:writter/widgets/drop_down.dart';

import '../constants/constants.dart';
import '../widgets/text_widget.dart';

class Services {
  static Future<void> showModelSheet(BuildContext context) async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        backgroundColor: scaffoldBackgroundColor,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  children: const [
                    Flexible(
                      child: TextWidget(
                        label: 'Choose Model:',
                        fontSize: 16,
                      ),
                    ),
                    Flexible(flex: 2, child: ModelDropeDownWidget()),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/buyTokens');
                    },
                    child: const TextWidget(
                      label: 'buy tokens',
                    ))
              ],
            ),
          );
        });
  }
}
