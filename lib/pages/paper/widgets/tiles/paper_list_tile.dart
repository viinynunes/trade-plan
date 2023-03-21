import 'package:flutter/material.dart';
import 'package:trade_plan/models/paper_model.dart';

class PaperListTile extends StatelessWidget {
  const PaperListTile(
      {Key? key,
      required this.onTap,
      required this.onLongPress,
      required this.paper})
      : super(key: key);

  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final PaperModel paper;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Nome',
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(paper.name),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Pontos por tick',
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(paper.pointsPerTicks.toString()),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Taxa por contrato',
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      // ignore: prefer_adjacent_string_concatenation
                      r'$' + '${paper.taxByContract?.toStringAsFixed(2) ?? 0}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
