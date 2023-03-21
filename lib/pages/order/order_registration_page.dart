import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_plan/core/ui/bloc/base_bloc_state.dart';
import 'package:trade_plan/models/operation_model.dart';
import 'package:trade_plan/models/paper_model.dart';
import 'package:trade_plan/pages/order/controller/states/order_registration_state.dart';
import 'package:validatorless/validatorless.dart';
import 'package:trade_plan/core/extensions/date_format_extension.dart';
import 'package:trade_plan/pages/order/controller/order_registration_bloc.dart';

import '../../core/ui/states/base_state.dart';
import '../../models/enums/order_status_enum.dart';
import '../../models/order_model.dart';

class OrderRegistrationPage extends StatefulWidget {
  const OrderRegistrationPage({Key? key}) : super(key: key);

  @override
  State<OrderRegistrationPage> createState() => _OrderRegistrationPageState();
}

class _OrderRegistrationPageState
    extends BaseState<OrderRegistrationPage, OrderRegistrationBloc> {
  OperationModel? selectedOperation;
  PaperModel? selectedPaper;

  DateTime selectedDate = DateTime.now();
  String selectedDateLabel = DateTime.now().dateAndTimeFormat;

  final positionSizeEC = TextEditingController();
  final entryPointEC = TextEditingController();
  final stopLossEC = TextEditingController();
  final expectedTakeProfitEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void onReady() {
    bloc.getPaperList();
    bloc.getOperationList();

    positionSizeEC.text = '1';
    stopLossEC.text = '200';
    expectedTakeProfitEC.text = '500';
  }

  @override
  void dispose() {
    stopLossEC.dispose();
    entryPointEC.dispose();
    positionSizeEC.dispose();
    expectedTakeProfitEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    showDatePickerDialog() async {
      return await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(3000));
    }

    showTimePickerDialog() async {
      return await showTimePicker(
          context: context, initialTime: TimeOfDay.now());
    }

    return BlocListener<OrderRegistrationBloc, OrderRegistrationState>(
      listener: (_, state) {
        if (state.baseStatus == BaseBlocStatus.loading) {
          showLoader();
        }

        if (state.status == OrderRegistrationStatusEnum.getListSuccess) {
          hideLoader();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrar nova ordem'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(
                    context,
                    OrderModel(
                        operation: selectedOperation!,
                        paper: selectedPaper!,
                        contracts: double.parse(positionSizeEC.text),
                        enterPoint: double.parse(entryPointEC.text),
                        stopLoss: int.parse(stopLossEC.text),
                        expectedTakeProfit:
                            int.parse(expectedTakeProfitEC.text),
                        executionTime: selectedDate,
                        status: OrderStatusEnum.open));
              }
            },
            label: Row(
              children: const [
                Icon(Icons.save),
                SizedBox(
                  width: 10,
                ),
                Text('Registrar'),
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dados do Ativo',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Selecione o papel',
                    style: textTheme.bodyLarge,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BlocSelector<OrderRegistrationBloc,
                            OrderRegistrationState, List<PaperModel>>(
                          selector: (state) => state.paperList,
                          builder: (context, paperList) {
                            return DropdownButtonFormField(
                              value: selectedPaper,
                              hint: const Text('Ex: WINFUT'),
                              iconSize: 0,
                              items: paperList
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.name),
                                      ))
                                  .toList(),
                              onChanged: (e) {
                                setState(() {
                                  selectedPaper = e;
                                });
                              },
                              validator: (paper) {
                                if (paper == null) {
                                  return 'Papel não selecionado';
                                }

                                return null;
                              },
                            );
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        tooltip: 'Crie um novo papel',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Selecione a operação',
                    style: textTheme.bodyLarge,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BlocSelector<OrderRegistrationBloc,
                            OrderRegistrationState, List<OperationModel>>(
                          selector: (state) => state.operationList,
                          builder: (context, operationList) {
                            return DropdownButtonFormField<OperationModel>(
                              value: selectedOperation,
                              iconSize: 0,
                              hint: const Text('Ex: Scalping'),
                              items: operationList
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.name),
                                      ))
                                  .toList(),
                              onChanged: (e) {
                                setState(() {
                                  selectedOperation = e;
                                });
                              },
                              validator: (operation) {
                                if (operation == null) {
                                  return 'Operação não selecionada';
                                }

                                return null;
                              },
                            );
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        tooltip: 'Crie um novo tipo de operação',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Parametros da posição',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Tamanho da Posição',
                        style: textTheme.bodyLarge,
                      ),
                      Text(
                        'Data da Operação',
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 50,
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: positionSizeEC,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              validator: Validatorless.multiple([
                                Validatorless.number('Inválido'),
                                Validatorless.required('Obrigatório'),
                                (a) {
                                  double number = double.parse(a!);
                                  if (number <= 0) {
                                    return 'Inválido';
                                  }

                                  return null;
                                }
                              ]),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Contrato/s',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final date = await showDatePickerDialog();

                          if (date != null) {
                            final time = await showTimePickerDialog();

                            if (time != null) {
                              final selectedDate = DateTime(date.year,
                                  date.month, date.day, time.hour, time.minute);

                              setState(() {
                                this.selectedDate = selectedDate;
                                selectedDateLabel =
                                    selectedDate.dateAndTimeFormat;
                              });
                            }
                          }
                        },
                        icon: const Icon(Icons.calendar_month),
                        label: Text(selectedDateLabel),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Ponto de entrada',
                            style: textTheme.bodyLarge
                                ?.copyWith(color: colorScheme.primary),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 80,
                            height: 50,
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: entryPointEC,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary),
                              validator: Validatorless.multiple([
                                Validatorless.number('Inválido'),
                                Validatorless.required('Obrigatório')
                              ]),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Stop Loss',
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge
                                ?.copyWith(color: colorScheme.tertiary),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 80,
                            height: 50,
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: stopLossEC,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.tertiary),
                              validator: Validatorless.multiple([
                                Validatorless.number('Inválido'),
                                Validatorless.required('Obrigatório'),
                                (text) {
                                  int number = int.parse(text!);

                                  if (number < 0) {
                                    return 'Inválido';
                                  }

                                  return null;
                                }
                              ]),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Saída esperada',
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge
                                ?.copyWith(color: colorScheme.secondary),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 80,
                            height: 50,
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: expectedTakeProfitEC,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.secondary),
                              validator: (text) {
                                if (text != null) {
                                  int number = int.parse(text);

                                  if (number < 0) {
                                    return 'Inválido';
                                  }
                                }

                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Detalhes da Operação de Continuidade',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Operação de $selectedOperation'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Descrição da Operação'),
                      const Text(
                          'A operação de continuidade ocorre após o inicio de uma tendência. Deve-se observar uma causa previamente contruída e com o mercado indo em diração aos pontos importantes'),
                      const Text('Media de pontos da operação: 100 pontos'),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
