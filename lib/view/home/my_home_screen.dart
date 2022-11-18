import 'package:flutter/material.dart';
import 'package:login_register/provider/test_api_provider.dart';
import 'package:provider/provider.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TestAPIProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: const Center(
          child: Text('Home'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            provider.deleteData(id: 1);
          },
        ),
      );
    });
  }
}
