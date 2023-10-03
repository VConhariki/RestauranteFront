import 'package:dio/dio.dart';
import 'package:flutter_application_teste/configs/app_configs.dart';

import '../../../../http.dart';
import '../models/produto.dart';
import '../repository/i_repository.dart';

class ProdutoRepository implements IRepository<Produto> {
  String baseUrl = AppConfigs.baseUrl;

  @override
  Future<List<Produto>> getAll() async {
    Response response = await dio.get('$baseUrl/produto/obter-produtos');
    return List<Produto>.from(response.data.map((x) => Produto.fromJson(x)));
  }

  @override
  Future<Produto?> get(int id) async {
    Response response = await dio.get(
      '$baseUrl/produto/obter-produto',
      options: Options(
        headers: {
          "id": id,
        },
      ),
    );
    return Produto.fromJson(response.data);
  }

  @override
  Future<void> post(Produto produto) async {
    await dio.post('$baseUrl/produto/inserir-produto', data: produto.toJson());
  }

  @override
  Future<void> put(Produto produto) async {
    await dio.put('$baseUrl/produto/alterar-produto', data: produto.toJson());
  }

  @override
  Future<void> delete(int id) async {
    await dio.delete(
      '$baseUrl/produto/deletar-produto',
      options: Options(
        headers: {
          "id": id,
        },
      ),
    );
  }
}
