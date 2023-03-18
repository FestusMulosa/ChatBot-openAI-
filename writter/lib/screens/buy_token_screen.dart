import 'package:flutter/material.dart';
import 'package:writter/widgets/app_Bar.dart';
import 'package:writter/widgets/buy_token_card.dart';

import '../constants/buy_tokens.dart';

class BuyTokenScreen extends StatelessWidget {
  const BuyTokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(children: [
        ...tokenPurchase
            .map(
              (tokenData) => BuyTokenCard(
                  numberOfTokens: tokenData.number, price: tokenData.amount),
            )
            .toList()
      ]),
    );
  }
}
