import 'package:flutter/material.dart';
import 'package:flutter_application_teste/features/management/presentation/widgets/mesas_management/mesa_card.dart';
import 'package:flutter_application_teste/features/management/presentation/widgets/mesas_management/mesa_form.dart';
import 'package:flutter_application_teste/shared/domain/models/mesa.dart';
import 'package:flutter_application_teste/shared/domain/services/mesa_repository.dart';

class MesasManagementScreen extends StatefulWidget {
  const MesasManagementScreen({super.key});

  @override
  State<MesasManagementScreen> createState() => _MesasManagementScreenState();
}

class _MesasManagementScreenState extends State<MesasManagementScreen> {
  late Future<List<Mesa>> _mesaList;
  final _mesaRepository = MesaRepository();

  void editFunction(Mesa mesa) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return MesaForm(
          mesa: mesa,
        );
      },
    );
    setState(() {
      _mesaList = getMesas();
    });
  }

  void deleteFunction(Mesa mesa) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir mesa'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                    'Você tem certeza que gostaria de excluir a mesa "${mesa.numero}"?'),
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
                await _mesaRepository.delete(mesa.id!);
                if (!mounted) return;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    setState(() {
      _mesaList = getMesas();
    });
  }

  Future<List<Mesa>> getMesas() async {
    return await _mesaRepository.getAll();
  }

  @override
  void initState() {
    super.initState();
    _mesaList = getMesas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Mesa>>(
        future: _mesaList,
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
                      "Mesas",
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
                            child: MesaCard(
                              mesa: snapshot.data![i],
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
              return const MesaForm(
                mesa: null,
              );
            },
          );
          setState(() {
            _mesaList = getMesas();
          });
        },
      ),
    );
  }
}
