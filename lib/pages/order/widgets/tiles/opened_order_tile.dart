import 'package:flutter/material.dart';
import 'package:trade_plan/core/extensions/date_format_extension.dart';
import 'package:trade_plan/pages/order/controller/order_list_bloc.dart';

import '../../../../core/ui/states/base_state.dart';
import '../../../../models/order_model.dart';

class OpenedOrderTile extends StatefulWidget {
  const OpenedOrderTile(
      {Key? key,
      required this.order,
      required this.onCloseOrder,
      required this.onLongPress})
      : super(key: key);

  final OrderModel order;
  final VoidCallback onCloseOrder;
  final VoidCallback onLongPress;

  @override
  State<OpenedOrderTile> createState() => _OpenedOrderTileState();
}

class _OpenedOrderTileState extends BaseState<OpenedOrderTile, OrderListBloc> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.primaryContainer;
    final textColor = theme.colorScheme.onPrimaryContainer;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onLongPress: widget.onLongPress,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.order.paper.name,
                    style: textTheme.bodyLarge?.copyWith(color: textColor),
                  ),
                  Text(
                    widget.order.operation.name,
                    style: textTheme.bodyLarge?.copyWith(color: textColor),
                  ),
                  Text(
                    widget.order.executionTime.onlyTimeFormat,
                    style: textTheme.bodyLarge?.copyWith(color: textColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Ponto de entrada: '),
                          Text(widget.order.enterPoint.toStringAsFixed(2)),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text('Tamanho do Stop Loss: '),
                          Text(widget.order.stopLoss.toStringAsFixed(0)),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text('Alvo final: '),
                          Text(widget.order.expectedTakeProfit
                              .toStringAsFixed(0)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text('Contratos: '),
                          Text(widget.order.contracts.toStringAsFixed(0)),
                        ],
                      ),
                      GestureDetector(
                        onTap: widget.onCloseOrder,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Encerrar Posição',
                            style: textTheme.bodyLarge
                                ?.copyWith(color: colorScheme.tertiary),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
