import 'item.dart';
import 'pedido.dart';

class ItemPedido {
  late int? id;
  late int pedidoId;
  late Pedido? pedido;
  late int itemId;
  late Item? item;

  ItemPedido(
      {this.id,
      required this.pedidoId,
      this.pedido,
      required this.itemId,
      this.item});

  ItemPedido.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pedidoId = json['pedidoId'];
    pedido = Pedido.fromJson(json['pedido']);
    itemId = json['itemId'];
    item = Item.fromJson(json['item']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pedidoId'] = pedidoId;
    data['pedido'] = pedido?.toJson();
    data['itemId'] = itemId;
    data['item'] = item?.toJson();
    return data;
  }
}
