import 'produto.dart';

class Item {
  late int? id;
  late int produtoId;
  late Produto? produto;
  late int quantidade;
  late String? observacao;
  late bool foiEnviadoCozinha;

  Item(
      {this.id,
      required this.produtoId,
      this.produto,
      required this.quantidade,
      this.observacao,
      required this.foiEnviadoCozinha});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    produtoId = json['produtoId'];
    produto =
        json['produto'] != null ? Produto.fromJson(json['produto']) : null;
    quantidade = json['quantidade'];
    observacao = json['observacao'];
    foiEnviadoCozinha = json['foiEnviadoCozinha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['produtoId'] = produtoId;
    if (produto != null) {
      data['produto'] = produto!.toJson();
    }
    data['quantidade'] = quantidade;
    data['observacao'] = observacao;
    data['foiEnviadoCozinha'] = foiEnviadoCozinha;
    return data;
  }
}
