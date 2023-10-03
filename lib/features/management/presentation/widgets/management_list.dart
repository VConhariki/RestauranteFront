import 'package:flutter/material.dart';
import 'package:flutter_application_teste/features/management/presentation/screens/item_pedidos_management/item_pedidos_management_screen.dart';
import 'package:flutter_application_teste/features/management/presentation/screens/itens_management/itens_management_screen.dart';
import 'package:flutter_application_teste/features/management/presentation/screens/mesas_management/mesas_management_screen.dart';
import 'package:flutter_application_teste/features/management/presentation/screens/pedidos_management/pedidos_management_screen.dart';
import 'package:flutter_application_teste/features/management/presentation/screens/produtos_management/produtos_management_screen.dart';
import 'package:flutter_application_teste/features/management/presentation/widgets/management_card.dart';

class ManagementList extends StatelessWidget {
  const ManagementList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5, bottom: 15),
          child: Text(
            "Gerenciamento",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ManagementCard(
                  title: "Produtos",
                  screenRoute: ProdutosManagementScreen(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ManagementCard(
                  title: "Mesas",
                  screenRoute: MesasManagementScreen(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ManagementCard(
                  title: "Itens",
                  screenRoute: ItensManagementScreen(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ManagementCard(
                  title: "Pedidos",
                  screenRoute: PedidosManagementScreen(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ManagementCard(
                  title: "ItemPedidos",
                  screenRoute: ItemPedidosManagementScreen(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
