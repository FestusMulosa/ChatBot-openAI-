import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:writter/constants/api_constants.dart';
import 'package:writter/models/chat_model.dart';
import '../models/models_model.dart';

class ApiServices {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse("$BASE_URL/models"),
          headers: {'Authorization': 'Bearer $API_KEY'});

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List temp = jsonResponse['data']
          .where((model) =>
              model['id'] == 'gpt-3.5-turbo' ||
              model['id'] == 'gpt-3.5-turbo-0301')
          .toList();
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log('error $error');
      rethrow;
    }
  }

  //send message
  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      log('modelId $modelId');
      var response = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'model': modelId,
          'messages': [
            {"role": "user", "content": message}
          ],
          'temperature': 0.7,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];

      if (jsonResponse['choices'].length > 0) {
        String content = jsonResponse['choices'][0]['message']['content'];
        chatList = [ChatModel(msg: content, chatIndex: 1)];
      }

      return chatList;
    } catch (error) {
      log('error $error');
      rethrow;
    }
  }
}
