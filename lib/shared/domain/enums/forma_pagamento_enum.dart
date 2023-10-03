enum FormaPagamentoEnum {
  cartaoCredito(1, "Cartão de Crédito"),
  cartaoDebito(2, "Cartão de Débito"),
  dinheiro(3, "Dinheiro"),
  pix(4, "Pix");

  final int id;
  final String description;

  const FormaPagamentoEnum(this.id, this.description);
}
