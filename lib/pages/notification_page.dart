import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Minhas notificações'),
        ),
      ),
      body: const Center(
        child: Text('Notificações'),
      ),
    );
  }
}
