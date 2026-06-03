import 'package:flutter/material.dart';
import 'package:my_first_app/provider/candidate_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CandidateProvider(),
      child: MaterialApp.router(
        title: 'App do Elcio',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 97, 171, 255),
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
