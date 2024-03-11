import 'package:flutter/material.dart';

class SummaryValues extends StatelessWidget {
  const SummaryValues({
    super.key,
    required this.calculateNotBuyedItem,
    required this.calculateBuyedItem,
  });

  final double calculateNotBuyedItem;
  final double calculateBuyedItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Não marcados",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              "R\$ ${calculateNotBuyedItem.toStringAsFixed(2).replaceAll(".", ",")}",
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 19,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Marcados",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              "R\$ ${calculateBuyedItem.toStringAsFixed(2).replaceAll(".", ",")}",
              style: const TextStyle(
                color: Colors.green,
                fontSize: 19,
              ),
            ),
          ],
        )
      ],
    );
  }
}
