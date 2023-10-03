import 'package:flutter/material.dart';
import 'package:flutter_application_teste/shared/domain/models/item_pedido.dart';
import 'package:flutter_application_teste/shared/domain/models/item.dart';
import 'package:flutter_application_teste/shared/domain/models/pedido.dart';
import 'package:flutter_application_teste/shared/domain/services/item_pedido_repository.dart';
import 'package:flutter_application_teste/shared/domain/services/item_repository.dart';
import 'package:flutter_application_teste/shared/domain/services/pedido_repository.dart';

class ItemPedidoForm extends StatefulWidget {
  const ItemPedidoForm({super.key, required this.itemPedido});

  final ItemPedido? itemPedido;

  @override
  State<ItemPedidoForm> createState() => _ItemPedidoFormState();
}

class _ItemPedidoFormState extends State<ItemPedidoForm> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _itemPedidoRepository = ItemPedidoRepository();
  final _itemRepository = ItemRepository();
  final _pedidoRepository = PedidoRepository();

  late Future<List<Item>> _itemList;
  late Future<List<Pedido>> _pedidoList;

  late int? id = widget.itemPedido?.id;
  Item? item;
  Pedido? pedido;

  _sendForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.itemPedido != null
          ? await _itemPedidoRepository.put(
              ItemPedido(id: id!, itemId: item!.id!, pedidoId: pedido!.id!),
            )
          : await _itemPedidoRepository.post(
              ItemPedido(itemId: item!.id!, pedidoId: pedido!.id!),
            );
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<List<Item>> getItems() async {
    return await _itemRepository.getAll();
  }

  Future<List<Pedido>> getPedidos() async {
    return await _pedidoRepository.getAll();
  }

  @override
  void initState() {
    super.initState();
    _itemList = getItems();
    _pedidoList = getPedidos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_itemList, _pedidoList]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            item ??= snapshot.data![0].first as Item;
            pedido ??= snapshot.data![1].first as Pedido;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.itemPedido != null
                      ? "Editar itemPedido"
                      : 'Inserir novo itemPedido',
                ),
                automaticallyImplyLeading: false,
              ),
              body: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      if (item != null)
                        DropdownButtonFormField<Item>(
                          decoration:
                              const InputDecoration(label: Text('Id do item')),
                          isExpanded: true,
                          value: item,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 0,
                          onChanged: (Item? value) {
                            setState(() {
                              item = value!;
                            });
                          },
                          items: snapshot.data![0].map<DropdownMenuItem<Item>>(
                            (dynamic value) {
                              return DropdownMenuItem<Item>(
                                value: value,
                                child: Text(value.id.toString()),
                              );
                            },
                          ).toList(),
                        ),
                      if (pedido != null)
                        DropdownButtonFormField<Pedido>(
                          decoration: const InputDecoration(
                              label: Text('Id do pedido')),
                          isExpanded: true,
                          value: pedido,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 0,
                          onChanged: (Pedido? value) {
                            setState(() {
                              pedido = value!;
                            });
                          },
                          items:
                              snapshot.data![1].map<DropdownMenuItem<Pedido>>(
                            (dynamic value) {
                              return DropdownMenuItem<Pedido>(
                                value: value,
                                child: Text(value.id.toString()),
                              );
                            },
                          ).toList(),
                        ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: const CircleBorder(),
                onPressed: _sendForm,
                child: const Icon(Icons.check),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}
