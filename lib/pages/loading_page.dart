import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).textTheme.headline6?.color,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Carregando',
            style: TextStyle(
              color: Theme.of(context).textTheme.headline6?.color,
            ),
          ),
        ],
      ),
    );
  }
}
