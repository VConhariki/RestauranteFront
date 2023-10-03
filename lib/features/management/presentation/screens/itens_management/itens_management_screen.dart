import 'package:flutter/material.dart';
import 'package:flutter_application_teste/features/management/presentation/widgets/itens_management/item_card.dart';
import 'package:flutter_application_teste/features/management/presentation/widgets/itens_management/item_form.dart';
import 'package:flutter_application_teste/shared/domain/models/item.dart';
import 'package:flutter_application_teste/shared/domain/services/item_repository.dart';

class ItensManagementScreen extends StatefulWidget {
  const ItensManagementScreen({super.key});

  @override
  State<ItensManagementScreen> createState() => _ItensManagementScreenState();
}

class _ItensManagementScreenState extends State<ItensManagementScreen> {
  late Future<List<Item>> _itemList;
  final _itemRepository = ItemRepository();

  void editFunction(Item item) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return ItemForm(
          item: item,
        );
      },
    );
    setState(() {
      _itemList = getItens();
    });
  }

  void deleteFunction(Item item) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                    'Você tem certeza que gostaria de excluir o item "${item.id}"?'),
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
                await _itemRepository.delete(item.id!);
                if (!mounted) return;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    setState(() {
      _itemList = getItens();
    });
  }

  Future<List<Item>> getItens() async {
    return await _itemRepository.getAll();
  }

  @override
  void initState() {
    super.initState();
    _itemList = getItens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Item>>(
        future: _itemList,
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
                      "Itens",
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
                            child: ItemCard(
                              item: snapshot.data![i],
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
              return const ItemForm(
                item: null,
              );
            },
          );
          setState(() {
            _itemList = getItens();
          });
        },
      ),
    );
  }
}
