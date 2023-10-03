import 'package:flutter_application_teste/shared/domain/enums/forma_pagamento_enum.dart';
import 'package:flutter_application_teste/shared/domain/enums/status_pedido_enum.dart';

import 'mesa.dart';

class Pedido {
  late int? id;
  late int? mesaId;
  late Mesa? mesa;
  late FormaPagamentoEnum? formaPagamento;
  late StatusPedidoEnum? status;
  late int total;

  Pedido(
      {this.id,
      this.mesaId,
      this.mesa,
      this.formaPagamento,
      required this.status,
      required this.total});

  Pedido.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mesaId = json['mesaId'];
    mesa = json['mesa'] != null ? Mesa.fromJson(json['mesa']) : null;
    formaPagamento = FormaPagamentoEnum.values[json['formaPagamento'] - 1];
    status = StatusPedidoEnum.values[json['status'] - 1];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mesaId'] = mesaId;
    if (mesa != null) {
      data['mesa'] = mesa!.toJson();
    }
    data['formaPagamento'] = formaPagamento?.id;
    data['status'] = status?.id;
    data['total'] = total;
    return data;
  }
}
