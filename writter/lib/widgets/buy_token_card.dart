// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:writter/widgets/text_widget.dart';

class BuyTokenCard extends StatelessWidget {
  int numberOfTokens;
  String price;

  BuyTokenCard({super.key, required this.numberOfTokens, required this.price});

  String tokenString = 'Tokens';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/payments');
        },
        child: Card(
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.monetization_on, color: Colors.yellow),
              TextWidget(
                label: '$numberOfTokens $tokenString',
                color: Colors.black,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue,
                  ),
                  padding: const EdgeInsets.all(3),
                  child: TextWidget(label: price, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
