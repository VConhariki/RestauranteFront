import 'package:flutter/material.dart';
import 'package:flutter_application_teste/features/management/presentation/screens/management_screen.dart';

class MainDrawerWidget extends StatelessWidget {
  const MainDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
          ListTile(
            title: const Text('Mesas'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => TablesScreen(),
              //   ),
              // );
            },
          ),
          ListTile(
            title: const Text('Gerenciamento'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManagementScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
