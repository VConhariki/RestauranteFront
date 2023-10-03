import 'package:dio/dio.dart';
import 'package:flutter_application_teste/configs/app_configs.dart';

import '../../../../http.dart';
import '../models/mesa.dart';
import '../repository/i_repository.dart';

class MesaRepository implements IRepository<Mesa> {
  String baseUrl = AppConfigs.baseUrl;

  @override
  Future<List<Mesa>> getAll() async {
    Response response = await dio.get('$baseUrl/mesa/obter-mesas');
    return List<Mesa>.from(response.data.map((x) => Mesa.fromJson(x)));
  }

  @override
  Future<Mesa?> get(int id) async {
    Response response = await dio.get(
      '$baseUrl/mesa/obter-mesa',
      options: Options(
        headers: {
          "id": id,
        },
      ),
    );
    return Mesa.fromJson(response.data);
  }

  @override
  Future<void> post(Mesa mesa) async {
    await dio.post('$baseUrl/mesa/inserir-mesa', data: mesa.toJson());
  }

  @override
  Future<void> put(Mesa mesa) async {
    await dio.put('$baseUrl/mesa/alterar-mesa', data: mesa.toJson());
  }

  @override
  Future<void> delete(int id) async {
    await dio.delete(
      '$baseUrl/mesa/deletar-mesa',
      options: Options(
        headers: {
          "id": id,
        },
      ),
    );
  }
}
