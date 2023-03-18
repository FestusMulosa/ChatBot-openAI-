import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:writter/constants/constants.dart';
import 'package:writter/providers/chat_provider.dart';
import 'package:writter/providers/models_provider.dart';
import 'package:writter/widgets/chat_widget.dart';
import 'package:writter/widgets/text_widget.dart';

import '../providers/token_provider.dart';
import '../widgets/app_Bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late ScrollController _listScrowController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    _listScrowController = ScrollController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    _listScrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelesProvider = Provider.of<ModelesProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: Column(children: [
          Flexible(
            // BUILD CHAT LIST

            child: ListView.builder(
                controller: _listScrowController,
                itemCount: chatProvider.getChatList.length,
                itemBuilder: ((context, index) {
                  return ChartWidget(
                    chatIndex: chatProvider.getChatList[index].chatIndex,
                    msg: chatProvider.getChatList[index].msg,
                  );
                })),
          ),

          //LOADING ANIMATION
          if (_isTyping) ...[
            const SpinKitThreeBounce(color: Colors.white, size: 18),
            const SizedBox(
              height: 15,
            ),
          ],

          //TEXT INPUT FIELD
          Material(
            color: cardColor,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: focusNode,
                    style: const TextStyle(color: Colors.white),
                    controller: textEditingController,
                    onSubmitted: (value) async {
                      context.read<TokenProvider>().decrementToken();
                      await sendMessageFCT(
                          modelesProvider: modelesProvider,
                          chatProvider: chatProvider);
                    },
                    decoration: const InputDecoration.collapsed(
                        hintText: 'how can i help you',
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.send),
                    color: Colors.white,
                    onPressed: () async {
                      context.read<TokenProvider>().decrementToken();
                      await sendMessageFCT(
                          modelesProvider: modelesProvider,
                          chatProvider: chatProvider);
                    }),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void scrollListToEnd() {
    _listScrowController.animateTo(
        _listScrowController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT(
      {required ModelesProvider modelesProvider,
      required ChatProvider chatProvider}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: TextWidget(
          label: 'Please Wait for the Response',
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: TextWidget(
          label: 'Please Type a Question',
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(
          msg: msg, chosenModelId: modelesProvider.currentModel);
      setState(() {});
    } catch (error) {
      log('error $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(
          label: error.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollListToEnd();
        _isTyping = false;
      });
    }
  }
}
