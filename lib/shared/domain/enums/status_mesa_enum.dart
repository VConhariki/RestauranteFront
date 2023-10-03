enum StatusMesaEnum {
  disponivel(1, 'Disponível'),
  ocupada(2, 'Ocupada');

  final int id;
  final String description;

  const StatusMesaEnum(this.id, this.description);
}
