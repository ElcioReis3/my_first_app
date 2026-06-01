import 'package:flutter/material.dart';
import 'package:my_first_app/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App do Elcio',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 97, 171, 255),
        ),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
