import 'package:dio/dio.dart';
import 'package:flutter_application_teste/configs/app_configs.dart';

import '../../../../http.dart';
import '../models/pedido.dart';
import '../repository/i_repository.dart';

class PedidoRepository implements IRepository<Pedido> {
  String baseUrl = AppConfigs.baseUrl;

  @override
  Future<List<Pedido>> getAll() async {
    Response response = await dio.get('$baseUrl/pedido/obter-pedidos');
    return List<Pedido>.from(response.data.map((x) => Pedido.fromJson(x)));
  }

  @override
  Future<Pedido?> get(int id) async {
    Response response = await dio.get(
      '$baseUrl/pedido/obter-pedido',
      options: Options(
        headers: {
          "id": id,
        },
      ),
    );
    return Pedido.fromJson(response.data);
  }

  @override
  Future<void> post(Pedido pedido) async {
    await dio.post('$baseUrl/pedido/inserir-pedido', data: pedido.toJson());
  }

  @override
  Future<void> put(Pedido pedido) async {
    await dio.put('$baseUrl/pedido/alterar-pedido', data: pedido.toJson());
  }

  @override
  Future<void> delete(int id) async {
    await dio.delete(
      '$baseUrl/pedido/deletar-pedido',
      options: Options(
        headers: {
          "id": id,
        },
      ),
    );
  }
}
