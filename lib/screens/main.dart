 import 'package:flutter/material.dart';
 void main() {
  runApp(const MyApp());
 }

 class MyApp extends StatelessWidget {
  const MyApp ({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ron'),
      ),
      body: Column(
        children:[Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: const Text(''),
        )
      ],
      ),
      );
  }
 }                                                                                                                              