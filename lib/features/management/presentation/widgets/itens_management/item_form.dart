import 'package:flutter/material.dart';
import 'package:flutter_application_teste/shared/domain/models/item.dart';
import 'package:flutter_application_teste/shared/domain/models/produto.dart';
import 'package:flutter_application_teste/shared/domain/services/item_repository.dart';
import 'package:flutter_application_teste/shared/domain/services/produto_repository.dart';

class ItemForm extends StatefulWidget {
  const ItemForm({super.key, required this.item});

  final Item? item;

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _itemRepository = ItemRepository();
  final _produtoRepository = ProdutoRepository();

  late Future<List<Produto>> _produtoList;

  late int? id = widget.item?.id;
  late int quantidade;
  late String? observacao;
  late bool foiEnviadoCozinha = true;
  Produto? produto;

  _sendForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.item != null
          ? await _itemRepository.put(
              Item(
                id: id!,
                produtoId: produto!.id!,
                produto: produto,
                quantidade: quantidade,
                observacao: observacao,
                foiEnviadoCozinha: foiEnviadoCozinha,
              ),
            )
          : await _itemRepository.post(
              Item(
                produtoId: produto!.id!,
                produto: produto,
                quantidade: quantidade,
                observacao: observacao,
                foiEnviadoCozinha: foiEnviadoCozinha,
              ),
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
    return FutureBuilder<List<Produto>>(
        future: _produtoList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            produto ??= snapshot.data!.first;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.item != null ? "Editar item" : 'Inserir novo item',
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
                      if (snapshot.data!.isNotEmpty)
                        DropdownButtonFormField<Produto>(
                          decoration:
                              const InputDecoration(label: Text("Produto")),
                          isExpanded: true,
                          value: produto,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 0,
                          onChanged: (Produto? value) {
                            setState(() {
                              produto = value!;
                            });
                          },
                          items: snapshot.data!.map<DropdownMenuItem<Produto>>(
                            (Produto value) {
                              return DropdownMenuItem<Produto>(
                                value: value,
                                child: Text(value.descricao.toString()),
                              );
                            },
                          ).toList(),
                        ),
                      TextFormField(
                        initialValue: widget.item?.observacao,
                        decoration:
                            const InputDecoration(label: Text('Observação')),
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          observacao = value;
                          return;
                        },
                      ),
                      TextFormField(
                          initialValue: widget.item?.quantidade.toString(),
                          decoration:
                              const InputDecoration(label: Text('Quantidade')),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            var parsedValue = int.tryParse(value ?? "");
                            if (parsedValue == null || parsedValue < 0) {
                              return 'Campo inválido';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            quantidade = int.parse(value!);
                          }),
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
