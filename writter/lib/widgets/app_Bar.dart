// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/token_provider.dart';
import '../services/assets_manager.dart';
import '../services/services.dart';

AppBar appBar(BuildContext context) {
  String? currentRoute = ModalRoute.of(context)?.settings.name;
  bool isBuyTokenScreen = currentRoute == '/buyTokens';

  return AppBar(
    actions: [
      IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          color: Colors.white,
          onPressed: () async {
            //show a model bottom sheet
            await Services.showModelSheet(context);
          }),
    ],
    title: Center(
      child: Text('Questions: ${Provider.of<TokenProvider>(context).token}'),
    ),
    elevation: 2,
    leading: isBuyTokenScreen
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetManager.logo),
          ),
  );
}
