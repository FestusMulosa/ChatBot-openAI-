import 'package:flutter/material.dart';
import 'package:writter/models/models_model.dart';
import 'package:writter/services/api_services.dart';

class ModelesProvider with ChangeNotifier {
  String currentModel = 'gpt-3.5-turbo';
  String get getCurrentModel => currentModel;

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList => modelsList;

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiServices.getModels();
    return modelsList;
  }
}
