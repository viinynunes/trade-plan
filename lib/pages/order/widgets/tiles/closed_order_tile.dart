import 'package:flutter/material.dart';
import 'package:trade_plan/core/extensions/date_format_extension.dart';
import 'package:trade_plan/models/closed_order_model.dart';

import '../../../../models/enums/order_result_enum.dart';

class ClosedOrderTile extends StatefulWidget {
  const ClosedOrderTile(
      {super.key, required this.closedOrder, required this.onLongPress});

  final ClosedOrderModel closedOrder;
  final VoidCallback onLongPress;

  @override
  State<ClosedOrderTile> createState() => _ClosedOrderTileState();
}

class _ClosedOrderTileState extends State<ClosedOrderTile> {
  Color getBackgroudColor(OrderResultStatus result, ColorScheme colorScheme) {
    if (result == OrderResultStatus.win) {
      return colorScheme.secondaryContainer;
    }
    if (result == OrderResultStatus.loss) {
      return colorScheme.tertiaryContainer;
    }

    return colorScheme.inversePrimary;
  }

  Color getTextColor(OrderResultStatus result, ColorScheme colorScheme) {
    if (result == OrderResultStatus.win) {
      return colorScheme.onSecondaryContainer;
    }
    if (result == OrderResultStatus.loss) {
      return colorScheme.onTertiaryContainer;
    }

    return colorScheme.onPrimaryContainer;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor =
        getBackgroudColor(widget.closedOrder.result, colorScheme);
    final textColor = getTextColor(widget.closedOrder.result, colorScheme);

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
                    widget.closedOrder.paper.name,
                    style: textTheme.bodyLarge?.copyWith(color: textColor),
                  ),
                  Text(
                    widget.closedOrder.operation.name,
                    style: textTheme.bodyLarge?.copyWith(color: textColor),
                  ),
                  Text(
                    widget.closedOrder.result.text,
                    style: textTheme.bodyLarge?.copyWith(color: textColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text('Horario da entrada: '),
                  Text(widget.closedOrder.executionTime.onlyTimeFormat),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text('Horario da saída: '),
                  Text(widget.closedOrder.closeTime.onlyTimeFormat),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Contratos: '),
                      Text(widget.closedOrder.contracts.toStringAsFixed(0)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Pontos: '),
                      Text(widget.closedOrder.pointsResult.toStringAsFixed(2)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(r'R$: '),
                      Text(
                          widget.closedOrder.getMoneyResult.toStringAsFixed(2)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
