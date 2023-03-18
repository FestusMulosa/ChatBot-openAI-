import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writter/constants/constants.dart';
import 'package:writter/models/models_model.dart';
import 'package:writter/providers/models_provider.dart';
import 'package:writter/widgets/text_widget.dart';

class ModelDropeDownWidget extends StatefulWidget {
  const ModelDropeDownWidget({super.key});

  @override
  State<ModelDropeDownWidget> createState() => _ModelDropeDownWidgetState();
}

class _ModelDropeDownWidgetState extends State<ModelDropeDownWidget> {
  String? currentModel;
  @override
  Widget build(BuildContext context) {
    final modelesProvider =
        Provider.of<ModelesProvider>(context, listen: false);

    currentModel = modelesProvider.getCurrentModel;
    return FutureBuilder<List<ModelsModel>>(
      future: modelesProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: TextWidget(
              label: snapshot.error.toString(),
            ),
          );
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox(
                child: DropdownButton(
                  dropdownColor: scaffoldBackgroundColor,
                  iconEnabledColor: Colors.white,
                  items: List<DropdownMenuItem<String>>.generate(
                    snapshot.data!.length,
                    (index) => DropdownMenuItem(
                      value: snapshot.data![index].id,
                      child: TextWidget(
                        label: snapshot.data![index].id,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  value: currentModel,
                  onChanged: (value) {
                    setState(() {
                      currentModel = value.toString();
                    });
                    modelesProvider.setCurrentModel(value.toString());
                  },
                ),
              );
      },
    );
  }
}
