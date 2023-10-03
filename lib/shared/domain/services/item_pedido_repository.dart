import 'package:dio/dio.dart';
import 'package:flutter_application_teste/configs/app_configs.dart';

import '../../../../http.dart';
import '../models/item_pedido.dart';
import '../repository/i_repository.dart';

class ItemPedidoRepository implements IRepository<ItemPedido> {
  String baseUrl = AppConfigs.baseUrl;

  @override
  Future<List<ItemPedido>> getAll() async {
    Response response =
        await dio.get('$baseUrl/itemPedido/obter-itensPedidosPedidos');
    return List<ItemPedido>.from(
        response.data.map((x) => ItemPedido.fromJson(x)));
  }

  @override
  Future<ItemPedido?> get(int id) async {
    Response response = await dio.get(
      '$baseUrl/itemPedido/obter-itemPedido',
      options: Options(
        headers: {
          "id": id,
        },
      ),
    );
    return ItemPedido.fromJson(response.data);
  }

  @override
  Future<void> post(ItemPedido itemPedido) async {
    await dio.post('$baseUrl/itemPedido/inserir-itemPedido',
        data: itemPedido.toJson());
  }

  @override
  Future<void> put(ItemPedido itemPedido) async {
    await dio.put('$baseUrl/itemPedido/alterar-itemPedido',
        data: itemPedido.toJson());
  }

  @override
  Future<void> delete(int id) async {
    await dio.delete(
      '$baseUrl/itemPedido/deletar-itemPedido',
      options: Options(
        headers: {
          "id": id,
        },
      ),
    );
  }
}
