enum StatusPedidoEnum {
  inicializado(1, 'Iniciado'),
  finalizado(2, 'Finalizado');

  final int id;
  final String description;

  const StatusPedidoEnum(this.id, this.description);
}
