import 'package:flutter/material.dart';
import 'package:trade_plan/core/extensions/date_format_extension.dart';
import 'package:trade_plan/models/closed_order_model.dart';
import 'package:trade_plan/models/enums/order_result_enum.dart';
import 'package:trade_plan/models/enums/order_status_enum.dart';
import 'package:trade_plan/models/order_model.dart';
import 'package:validatorless/validatorless.dart';

class CloseOrderDialog extends StatefulWidget {
  const CloseOrderDialog(
      {Key? key, required this.order, required this.onFinish})
      : super(key: key);

  final OrderModel order;
  final Function(ClosedOrderModel closedOrder) onFinish;

  @override
  State<CloseOrderDialog> createState() => _CloseOrderDialogState();
}

class _CloseOrderDialogState extends State<CloseOrderDialog> {
  late OrderResultStatus orderResult;
  DateTime selectedDate = DateTime.now();
  String selectedDateString = '';
  bool editMoneyManually = false;

  final pointsResultEC = TextEditingController();
  final taxEC = TextEditingController();
  final moneyResultEC = TextEditingController();
  final contractsEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    selectedDateString = selectedDate.dateAndTimeFormat;

    orderResult = OrderResultStatus.win;

    pointsResultEC.text = widget.order.expectedTakeProfit.toString();
    contractsEC.text = widget.order.contracts.toString();

    taxEC.text = widget.order.taxByContract?.toStringAsFixed(2) ?? '0';
    _calculateMoneyResult();
  }

  _setPointsByResultStatus(
      {required OrderResultStatus result, required double points}) {
    if (result == OrderResultStatus.win) {
      if (points.isNegative) {
        pointsResultEC.text = points.abs().toString();
      }
    }

    if (result == OrderResultStatus.loss) {
      if (!points.isNegative) {
        pointsResultEC.text = (points * (-1)).toString();
      }
    }
  }

  double _calculateTax() {
    final tax = widget.order.paper.taxByContract ?? 0;

    taxEC.text = (tax * double.parse(contractsEC.text)).toStringAsFixed(2);

    return tax;
  }

  double _calculateMoneyResult() {
    double tax = 0.0;

    if (taxEC.text.isNotEmpty) {
      tax = double.parse(taxEC.text);
    }

    double points = 0;

    if (pointsResultEC.text.isNotEmpty &&
        pointsResultEC.text != '-' &&
        pointsResultEC.text != '.') {
      points = double.parse(pointsResultEC.text);
    }

    if (tax >= 0 && !points.isNaN) {
      final moneyResult = (points / widget.order.paper.pointsPerTicks) *
              double.parse(contractsEC.text) -
          tax;
      moneyResultEC.text = moneyResult.toStringAsFixed(2);
      return moneyResult;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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

    return AlertDialog(
      title: const Center(child: Text('Encerrar Ordem')),
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Data de encerramento',
                          style: textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final date = await showDatePickerDialog();

                            if (date != null) {
                              final time = await showTimePickerDialog();

                              if (time != null) {
                                setState(() {
                                  selectedDate = DateTime(date.year, date.month,
                                      date.day, time.hour, time.minute);

                                  selectedDateString =
                                      selectedDate.dateAndTimeFormat;
                                });
                              }
                            }
                          },
                          child: Text(selectedDateString),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Contratos',
                          style: textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextFormField(
                            controller: contractsEC,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            onTap: () {
                              contractsEC.selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: contractsEC.value.text.length);
                            },
                            onChanged: (text) {
                              if (text.isNotEmpty) {
                                _calculateTax();
                                _calculateMoneyResult();
                              }
                            },
                            validator: Validatorless.required('Obrigatório'),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Selecione o resultado da operação',
                  style: textTheme.bodyLarge,
                ),
                DropdownButtonFormField<OrderResultStatus>(
                  value: orderResult,
                  items: [
                    DropdownMenuItem(
                      value: OrderResultStatus.win,
                      child: Text(
                        OrderResultStatus.win.text,
                        style: textTheme.bodyMedium?.copyWith(
                            color: OrderResultStatus.win.defaultColor),
                      ),
                    ),
                    DropdownMenuItem(
                      value: OrderResultStatus.tie,
                      child: Text(
                        OrderResultStatus.tie.text,
                        style: textTheme.bodyMedium?.copyWith(
                            color: OrderResultStatus.tie.defaultColor),
                      ),
                    ),
                    DropdownMenuItem(
                      value: OrderResultStatus.loss,
                      child: Text(
                        OrderResultStatus.loss.text,
                        style: textTheme.bodyMedium?.copyWith(
                            color: OrderResultStatus.loss.defaultColor),
                      ),
                    ),
                  ],
                  onChanged: (e) {
                    setState(() {
                      orderResult = e!;
                    });

                    if (pointsResultEC.text.isNotEmpty) {
                      _setPointsByResultStatus(
                          points: double.parse(pointsResultEC.text),
                          result: orderResult);

                      _calculateMoneyResult();
                    }
                  },
                  alignment: Alignment.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Digite a pontuação obtida',
                  style: textTheme.bodyLarge,
                ),
                TextFormField(
                  controller: pointsResultEC,
                  decoration: const InputDecoration(
                    hintText: 'Pontuação',
                    icon: Icon(Icons.donut_large),
                  ),
                  keyboardType: TextInputType.number,
                  onTap: () {
                    pointsResultEC.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: pointsResultEC.value.text.length);
                  },
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      _calculateMoneyResult();
                    }
                  },
                  onFieldSubmitted: (text) {
                    setState(() {
                      _setPointsByResultStatus(
                          result: orderResult, points: double.parse(text));
                    });
                  },
                  validator: Validatorless.required('Obrigatório'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Taxas',
                  style: textTheme.bodyLarge,
                ),
                TextFormField(
                  controller: taxEC,
                  decoration: const InputDecoration(
                    hintText: 'Total de taxa',
                    icon: Icon(Icons.money_off),
                  ),
                  keyboardType: TextInputType.number,
                  onTap: () {
                    taxEC.selection = TextSelection(
                        baseOffset: 0, extentOffset: taxEC.value.text.length);
                  },
                  onChanged: (text) {
                    _calculateMoneyResult();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Finenceiro',
                  style: textTheme.bodyLarge,
                ),
                TextFormField(
                  controller: moneyResultEC,
                  enabled: editMoneyManually,
                  decoration: const InputDecoration(
                    hintText: r'R$',
                    icon: Icon(Icons.attach_money_outlined),
                  ),
                  onTap: () {
                    moneyResultEC.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: moneyResultEC.value.text.length);
                  },
                  keyboardType: const TextInputType.numberWithOptions(),
                  validator: Validatorless.required('Obrigatório'),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      editMoneyManually = !editMoneyManually;
                    });
                  },
                  child: Row(
                    children: [
                      Checkbox(
                          value: editMoneyManually,
                          onChanged: (e) {
                            setState(() {
                              editMoneyManually = e!;
                            });
                          }),
                      const Text('Editar Financeiro Manualmente'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: Navigator.of(context).pop,
                      child: Text(
                        'Cancelar',
                        style: textTheme.bodyLarge?.copyWith(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.onFinish(
                            ClosedOrderModel(
                                closeTime: selectedDate,
                                result: orderResult,
                                pointsResult: double.parse(pointsResultEC.text),
                                operation: widget.order.operation,
                                paper: widget.order.paper,
                                contracts: double.parse(contractsEC.text),
                                enterPoint: widget.order.enterPoint,
                                stopLoss: widget.order.stopLoss,
                                expectedTakeProfit:
                                    widget.order.expectedTakeProfit,
                                executionTime: widget.order.executionTime,
                                status: OrderStatusEnum.closed),
                          );

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Salvar',
                        style:
                            textTheme.bodyLarge?.copyWith(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
