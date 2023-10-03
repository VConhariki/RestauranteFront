import 'package:flutter/material.dart';
import 'package:flutter_application_teste/features/management/presentation/widgets/produtos_management/produto_card.dart';
import 'package:flutter_application_teste/features/management/presentation/widgets/produtos_management/produto_form.dart';
import 'package:flutter_application_teste/shared/domain/models/produto.dart';
import 'package:flutter_application_teste/shared/domain/services/produto_repository.dart';

class ProdutosManagementScreen extends StatefulWidget {
  const ProdutosManagementScreen({super.key});

  @override
  State<ProdutosManagementScreen> createState() =>
      _ProdutosManagementScreenState();
}

class _ProdutosManagementScreenState extends State<ProdutosManagementScreen> {
  late Future<List<Produto>> _produtoList;
  final _produtoRepository = ProdutoRepository();

  void editFunction(Produto produto) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return ProdutoForm(
          produto: produto,
        );
      },
    );
    setState(() {
      _produtoList = getProdutos();
    });
  }

  void deleteFunction(Produto produto) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir produto'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                    'Você tem certeza que gostaria de excluir o produto "${produto.descricao}"?'),
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
                await _produtoRepository.delete(produto.id!);
                if (!mounted) return;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    setState(() {
      _produtoList = getProdutos();
    });
  }

  Future<List<Produto>> getProdutos() async {
    return await _produtoRepository.getAll();
  }

  @override
  void initState() {
    super.initState();
    _produtoList = getProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Produto>>(
        future: _produtoList,
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
                      "Produtos",
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
                            child: ProdutoCard(
                              produto: snapshot.data![i],
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
              return const ProdutoForm(
                produto: null,
              );
            },
          );
          setState(() {
            _produtoList = getProdutos();
          });
        },
      ),
    );
  }
}
