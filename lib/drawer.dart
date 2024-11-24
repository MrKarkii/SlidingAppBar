import 'package:flutter/material.dart';

class DrawerClass extends StatelessWidget {
  const DrawerClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar with hamburger button'),
        backgroundColor: Colors.green,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.h_mobiledata),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {},
          ),
        ],
      )),
    );
  }
}
