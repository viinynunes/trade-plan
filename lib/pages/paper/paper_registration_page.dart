import 'package:flutter/material.dart';
import 'package:trade_plan/models/paper_model.dart';
import 'package:validatorless/validatorless.dart';

class PaperRegistrationPage extends StatefulWidget {
  const PaperRegistrationPage({Key? key, required this.paper})
      : super(key: key);

  final PaperModel? paper;

  @override
  State<PaperRegistrationPage> createState() => _PaperRegistrationPageState();
}

class _PaperRegistrationPageState extends State<PaperRegistrationPage> {
  final formKey = GlobalKey<FormState>();

  final nameEC = TextEditingController();
  final pointsEC = TextEditingController();
  final taxEC = TextEditingController();

  final nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.paper != null) {
      nameEC.text = widget.paper!.name;
      pointsEC.text = widget.paper!.pointsPerTicks.toString();
      taxEC.text = widget.paper!.taxByContract?.toString() ?? '0';
    }

    nameFocus.requestFocus();
  }

  clearFields() {
    nameEC.clear();
    pointsEC.clear();
    taxEC.clear();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.paper != null ? 'Editar Ativo' : 'Novo Ativo'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: clearFields, icon: const Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Navigator.pop(
              context,
              PaperModel(
                id: widget.paper?.key,
                name: nameEC.text.toUpperCase(),
                pointsPerTicks: double.parse(pointsEC.text),
                taxByContract: double.parse(taxEC.text),
              ),
            );
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
              TextFormField(
                controller: nameEC,
                focusNode: nameFocus,
                decoration: const InputDecoration(hintText: 'WINFUT'),
                textInputAction: TextInputAction.next,
                validator: Validatorless.required(' Campo Obrigatório'),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Pontos por tick',
                style: textTheme.titleLarge,
              ),
              TextFormField(
                controller: pointsEC,
                decoration: const InputDecoration(hintText: '5'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: Validatorless.required(' Campo Obrigatório'),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Taxa por contrato',
                style: textTheme.titleLarge,
              ),
              TextFormField(
                controller: taxEC,
                decoration: const InputDecoration(hintText: r' $ 0.50'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
