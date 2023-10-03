import 'package:flutter/material.dart';
import 'package:flutter_application_teste/shared/domain/enums/forma_pagamento_enum.dart';
import 'package:flutter_application_teste/shared/domain/enums/status_pedido_enum.dart';
import 'package:flutter_application_teste/shared/domain/models/mesa.dart';
import 'package:flutter_application_teste/shared/domain/models/pedido.dart';
import 'package:flutter_application_teste/shared/domain/services/pedido_repository.dart';
import 'package:flutter_application_teste/shared/domain/services/mesa_repository.dart';

class PedidoForm extends StatefulWidget {
  const PedidoForm({super.key, required this.pedido});

  final Pedido? pedido;

  @override
  State<PedidoForm> createState() => _PedidoFormState();
}

class _PedidoFormState extends State<PedidoForm> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _pedidoRepository = PedidoRepository();
  final _mesaRepository = MesaRepository();

  late Future<List<Mesa>> _mesaList;

  late int? id = widget.pedido?.id;
  late FormaPagamentoEnum? formaPagamento = FormaPagamentoEnum.cartaoCredito;
  late StatusPedidoEnum? status = StatusPedidoEnum.inicializado;
  late int total = 0;
  Mesa? mesa;

  _sendForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.pedido != null
          ? await _pedidoRepository.put(
              Pedido(
                id: id!,
                mesaId: mesa!.id,
                mesa: mesa,
                formaPagamento: formaPagamento,
                status: status,
                total: total,
              ),
            )
          : await _pedidoRepository.post(
              Pedido(
                mesaId: mesa!.id,
                mesa: mesa,
                formaPagamento: formaPagamento,
                status: status,
                total: total,
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
    return FutureBuilder<List<Mesa>>(
        future: _mesaList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            mesa ??= snapshot.data!.first;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.pedido != null
                      ? "Editar pedido"
                      : 'Inserir novo pedido',
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
                        DropdownButtonFormField<Mesa>(
                          decoration: const InputDecoration(
                              label: Text('Número da mesa')),
                          isExpanded: true,
                          value: mesa,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 0,
                          onChanged: (Mesa? value) {
                            setState(() {
                              mesa = value!;
                            });
                          },
                          items: snapshot.data!.map<DropdownMenuItem<Mesa>>(
                            (Mesa value) {
                              return DropdownMenuItem<Mesa>(
                                value: value,
                                child: Text(value.numero.toString()),
                              );
                            },
                          ).toList(),
                        ),
                      DropdownButtonFormField<FormaPagamentoEnum>(
                        decoration: const InputDecoration(
                            label: Text('Forma de pagamento')),
                        isExpanded: true,
                        value: formaPagamento,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 0,
                        onChanged: (FormaPagamentoEnum? value) {
                          setState(() {
                            formaPagamento = value!;
                          });
                        },
                        items: FormaPagamentoEnum.values
                            .map<DropdownMenuItem<FormaPagamentoEnum>>(
                          (FormaPagamentoEnum value) {
                            return DropdownMenuItem<FormaPagamentoEnum>(
                              value: value,
                              child: Text(value.description),
                            );
                          },
                        ).toList(),
                      ),
                      if (widget.pedido != null)
                        DropdownButtonFormField<StatusPedidoEnum>(
                          decoration:
                              const InputDecoration(label: Text('Status')),
                          isExpanded: true,
                          value: status,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 0,
                          onChanged: (StatusPedidoEnum? value) {
                            setState(() {
                              status = value!;
                            });
                          },
                          items: StatusPedidoEnum.values
                              .map<DropdownMenuItem<StatusPedidoEnum>>(
                            (StatusPedidoEnum value) {
                              return DropdownMenuItem<StatusPedidoEnum>(
                                value: value,
                                child: Text(value.description),
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
