import 'package:dio/dio.dart';
import 'package:flutter_application_teste/configs/app_configs.dart';

import '../../../../http.dart';
import '../models/item.dart';
import '../repository/i_repository.dart';

class ItemRepository implements IRepository<Item> {
  String baseUrl = AppConfigs.baseUrl;

  @override
  Future<List<Item>> getAll() async {
    Response response = await dio.get('$baseUrl/item/obter-itens');
    return List<Item>.from(response.data.map((x) => Item.fromJson(x)));
  }

  @override
  Future<Item?> get(int id) async {
    Response response = await dio.get(
      '$baseUrl/item/obter-item',
      options: Options(
        headers: {
          "id": id,
        },
      ),
    );
    return Item.fromJson(response.data);
  }

  @override
  Future<void> post(Item item) async {
    await dio.post('$baseUrl/item/inserir-item', data: item.toJson());
  }

  @override
  Future<void> put(Item item) async {
    await dio.put('$baseUrl/item/alterar-item', data: item.toJson());
  }

  @override
  Future<void> delete(int id) async {
    await dio.delete(
      '$baseUrl/item/deletar-item',
      options: Options(
        headers: {
          "id": id,
        },
      ),
    );
  }
}
