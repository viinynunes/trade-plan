import 'package:flutter/material.dart';
import 'package:trade_plan/models/operation_model.dart';

class OperationListTile extends StatelessWidget {
  const OperationListTile(
      {Key? key,
      required this.operation,
      required this.onTap,
      required this.onLongPress})
      : super(key: key);

  final OperationModel operation;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nome',
                style: textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(operation.name),
            ],
          ),
        ),
      ),
    );
  }
}
