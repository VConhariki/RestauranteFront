import 'package:flutter/material.dart';
import 'package:flutter_application_teste/features/management/presentation/widgets/item_pedidos_management/item_pedido_card.dart';
import 'package:flutter_application_teste/features/management/presentation/widgets/item_pedidos_management/item_pedido_form.dart';
import 'package:flutter_application_teste/shared/domain/models/item_pedido.dart';
import 'package:flutter_application_teste/shared/domain/services/item_pedido_repository.dart';

class ItemPedidosManagementScreen extends StatefulWidget {
  const ItemPedidosManagementScreen({super.key});

  @override
  State<ItemPedidosManagementScreen> createState() =>
      _ItemPedidosManagementScreenState();
}

class _ItemPedidosManagementScreenState
    extends State<ItemPedidosManagementScreen> {
  late Future<List<ItemPedido>> _itemPedidoList;
  final _itemPedidoRepository = ItemPedidoRepository();

  void editFunction(ItemPedido itemPedido) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return ItemPedidoForm(
          itemPedido: itemPedido,
        );
      },
    );
    setState(() {
      _itemPedidoList = getItemPedidos();
    });
  }

  void deleteFunction(ItemPedido itemPedido) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir itemPedido'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                    'Você tem certeza que gostaria de excluir a itemPedido "${itemPedido.id}"?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () async {
                await _itemPedidoRepository.delete(itemPedido.id!);
                if (!mounted) return;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    setState(() {
      _itemPedidoList = getItemPedidos();
    });
  }

  Future<List<ItemPedido>> getItemPedidos() async {
    return await _itemPedidoRepository.getAll();
  }

  @override
  void initState() {
    super.initState();
    _itemPedidoList = getItemPedidos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<ItemPedido>>(
        future: _itemPedidoList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 15),
                    child: Text(
                      "ItemPedidos",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (int i = 0; i < (snapshot.data!.length); i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ItemPedidoCard(
                              itemPedido: snapshot.data![i],
                              editFunction: () =>
                                  editFunction(snapshot.data![i]),
                              deleteFunction: () =>
                                  deleteFunction(snapshot.data![i]),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            builder: (context) {
              return const ItemPedidoForm(
                itemPedido: null,
              );
            },
          );
          setState(() {
            _itemPedidoList = getItemPedidos();
          });
        },
      ),
    );
  }
}
