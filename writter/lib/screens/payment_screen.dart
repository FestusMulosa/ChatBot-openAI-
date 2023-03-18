import 'package:flutter/material.dart';
import 'package:writter/widgets/text_widget.dart';

class PayementScreen extends StatelessWidget {
  const PayementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: TextWidget(label: 'Make Payment'),
      ),
    );
  }
}
