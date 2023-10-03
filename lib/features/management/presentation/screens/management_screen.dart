import 'package:flutter/material.dart';
import 'package:flutter_application_teste/features/management/presentation/widgets/management_list.dart';
import 'package:flutter_application_teste/shared/widgets/drawers/main_drawer_widget.dart';

class ManagementScreen extends StatelessWidget {
  const ManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 35,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const MainDrawerWidget(),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: ManagementList(),
      ),
    );
  }
}
