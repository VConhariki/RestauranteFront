import 'package:flutter/material.dart';
import 'package:flutter_application_teste/shared/domain/models/item.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key, required this.item, this.editFunction, this.deleteFunction});
  final Item item;
  final Function()? editFunction;
  final Function()? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: item.observacao?.isNotEmpty ?? false ? 115 : 90,
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
                          "Item ${item.id.toString()}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${item.produto?.descricao.toString()} - x${item.quantidade}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        if (item.observacao?.isNotEmpty ?? false)
                          Text(
                            "Obs: ${item.observacao}",
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
