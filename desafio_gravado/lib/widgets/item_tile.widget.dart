import 'package:flutter/material.dart';
import 'package:shopping_cart/models/item_list.model.dart';

class ItemTile extends StatefulWidget {
  final ItemList item;
  final void Function() toggleCheckbox;
  const ItemTile({
    super.key,
    required this.item,
    required this.toggleCheckbox,
  });

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5,
          alignment: Alignment.centerRight,
          child: Checkbox(
            shape: const CircleBorder(),
            side: const BorderSide(
              color: Colors.blue,
            ),
            value: widget.item.buyed,
            onChanged: (value) => widget.toggleCheckbox(),
          ),
        ),
        Text(
          widget.item.name,
          style: TextStyle(
            fontSize: 18,
            color: widget.item.buyed ? Colors.grey : null,
          ),
        ),
        const Spacer(),
        Text(
          "R\$ ${widget.item.price.toStringAsFixed(2).replaceAll(".", ",")}",
          style: const TextStyle(
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
