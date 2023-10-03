import 'package:flutter/material.dart';
import 'package:flutter_application_teste/shared/domain/models/produto.dart';
import 'package:flutter_application_teste/shared/domain/services/produto_repository.dart';

class ProdutoForm extends StatefulWidget {
  const ProdutoForm({super.key, required this.produto});

  final Produto? produto;

  @override
  State<ProdutoForm> createState() => _ProdutoFormState();
}

class _ProdutoFormState extends State<ProdutoForm> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _produtoRepository = ProdutoRepository();

  late int? id = widget.produto?.id;
  late String descricao;
  late double preco;

  _sendForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.produto != null
          ? await _produtoRepository.put(
              Produto(
                id: id,
                descricao: descricao,
                preco: preco,
              ),
            )
          : await _produtoRepository.post(
              Produto(
                descricao: descricao,
                preco: preco,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.produto != null ? "Editar produto" : 'Inserir novo produto',
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
              TextFormField(
                initialValue: widget.produto?.descricao,
                decoration: const InputDecoration(label: Text('Produto')),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo inválido';
                  }
                  return null;
                },
                onSaved: (value) {
                  descricao = value!;
                  return;
                },
              ),
              TextFormField(
                  initialValue: widget.produto?.preco.toString(),
                  decoration: const InputDecoration(label: Text('Preço')),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    var parsedValue = double.tryParse(value ?? "");
                    if (parsedValue == null || parsedValue < 0) {
                      return 'Campo inválido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    preco = double.parse(value!);
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
  }
}
