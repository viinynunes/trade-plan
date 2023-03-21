import 'package:flutter/material.dart';
import 'package:trade_plan/models/operation_model.dart';
import 'package:validatorless/validatorless.dart';

class OperationRegistrationPage extends StatefulWidget {
  const OperationRegistrationPage({Key? key, this.operation}) : super(key: key);

  final OperationModel? operation;

  @override
  State<OperationRegistrationPage> createState() =>
      _OperationRegistrationPageState();
}

class _OperationRegistrationPageState extends State<OperationRegistrationPage> {
  final nameEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.operation != null) {
      nameEC.text = widget.operation!.name;
    }

    nameFocus.requestFocus();
  }

  clearFields() {
    nameEC.clear();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.operation != null ? 'Editar Operação' : 'Nova Operação'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: clearFields,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Navigator.pop(context,
                OperationModel(id: widget.operation?.key, name: nameEC.text));
          }
        },
        child: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome',
                  style: textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: nameEC,
                  focusNode: nameFocus,
                  decoration: const InputDecoration(hintText: 'Scalping'),
                  validator: Validatorless.required('Obrigatório'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
