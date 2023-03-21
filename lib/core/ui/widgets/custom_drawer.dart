import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 8),
        child: Column(
          children: [
            Text(
              'Trader Cicle',
              style: textTheme.titleLarge,
            ),
            const SizedBox(
              height: 100,
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.home),
                ],
              ),
              title: Center(
                child: Text(
                  'Home Page',
                  style: textTheme.bodyLarge,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed('/order-list'),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.monetization_on),
                ],
              ),
              title: Center(
                child: Text(
                  'Ordens',
                  style: textTheme.bodyLarge,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed('/operation-list'),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.insert_drive_file_rounded),
                ],
              ),
              title: Center(
                child: Text(
                  'Operaçõs',
                  style: textTheme.bodyLarge,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed('/paper-list'),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.app_registration),
                ],
              ),
              title: Center(
                child: Text(
                  'Ativos',
                  style: textTheme.bodyLarge,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.monetization_on),
                ],
              ),
              title: Center(
                child: Text(
                  'PCR',
                  style: textTheme.bodyLarge,
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
