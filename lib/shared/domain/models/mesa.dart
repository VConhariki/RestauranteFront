import 'package:flutter_application_teste/shared/domain/enums/status_mesa_enum.dart';

class Mesa {
  late int? id;
  late int numero;
  late StatusMesaEnum status;

  Mesa({this.id, required this.numero, required this.status});

  Mesa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numero = json['numero'];
    status = StatusMesaEnum.values[json['status'] - 1];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['numero'] = numero;
    data['status'] = status.id;
    return data;
  }
}
