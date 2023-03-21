import 'package:flutter/material.dart';

class CrudBottomMenu extends StatelessWidget {
  const CrudBottomMenu({Key? key, required this.onDelete}) : super(key: key);

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              onTap: onDelete,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Icon(Icons.delete)],
              ),
              title: const Center(child: Text('Deletar')),
            )
          ],
        ),
      ),
    );
  }
}
