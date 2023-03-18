import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writter/providers/chat_provider.dart';
import 'package:writter/providers/models_provider.dart';
import 'package:writter/screens/chat_screen.dart';
import 'package:writter/screens/payment_screen.dart';

import 'constants/theme.dart';
import 'providers/token_provider.dart';
import 'screens/buy_token_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TokenProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Writter',
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: const ChatScreen(),
        routes:
            //create routes here
            {
          '/buyTokens': (context) => const BuyTokenScreen(),
          '/payments': (context) => const PayementScreen(),
        },
      ),
    );
  }
}
