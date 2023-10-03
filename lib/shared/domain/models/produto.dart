class Produto {
  late int? id;
  late String? descricao;
  late double preco;

  Produto({this.id, this.descricao, required this.preco});

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    preco = double.parse(json['preco'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['descricao'] = descricao;
    data['preco'] = preco;
    return data;
  }
}
