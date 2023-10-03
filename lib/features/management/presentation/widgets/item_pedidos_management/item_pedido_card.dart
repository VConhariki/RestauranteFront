import 'package:flutter/material.dart';
import 'package:flutter_application_teste/shared/domain/models/item_pedido.dart';

class ItemPedidoCard extends StatelessWidget {
  const ItemPedidoCard(
      {super.key,
      required this.itemPedido,
      this.editFunction,
      this.deleteFunction});
  final ItemPedido itemPedido;
  final Function()? editFunction;
  final Function()? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ItemPedido ${itemPedido.id}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Item: ${itemPedido.itemId}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Pedido: ${itemPedido.pedidoId}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: editFunction,
                        color: Colors.white,
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: deleteFunction,
                        color: Colors.white,
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
