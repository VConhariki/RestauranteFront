import 'package:flutter/material.dart';
import 'package:flutter_application_teste/features/management/presentation/widgets/pedidos_management/pedido_card.dart';
import 'package:flutter_application_teste/features/management/presentation/widgets/pedidos_management/pedido_form.dart';
import 'package:flutter_application_teste/shared/domain/models/pedido.dart';
import 'package:flutter_application_teste/shared/domain/services/pedido_repository.dart';

class PedidosManagementScreen extends StatefulWidget {
  const PedidosManagementScreen({super.key});

  @override
  State<PedidosManagementScreen> createState() =>
      _PedidosManagementScreenState();
}

class _PedidosManagementScreenState extends State<PedidosManagementScreen> {
  late Future<List<Pedido>> _pedidoList;
  final _pedidoRepository = PedidoRepository();

  void editFunction(Pedido pedido) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return PedidoForm(
          pedido: pedido,
        );
      },
    );
    setState(() {
      _pedidoList = getPedidos();
    });
  }

  void deleteFunction(Pedido pedido) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir pedido'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                    'Você tem certeza que gostaria de excluir o pedido "${pedido.id}"?'),
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
                await _pedidoRepository.delete(pedido.id!);
                if (!mounted) return;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    setState(() {
      _pedidoList = getPedidos();
    });
  }

  Future<List<Pedido>> getPedidos() async {
    return await _pedidoRepository.getAll();
  }

  @override
  void initState() {
    super.initState();
    _pedidoList = getPedidos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Pedido>>(
        future: _pedidoList,
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
                      "Pedidos",
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
                            child: PedidoCard(
                              pedido: snapshot.data![i],
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
              return const PedidoForm(
                pedido: null,
              );
            },
          );
          setState(() {
            _pedidoList = getPedidos();
          });
        },
      ),
    );
  }
}
