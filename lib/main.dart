import 'package:flutter/material.dart';
import 'package:my_first_app/models/candidate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App do Pedro',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 97, 171, 255),
        ),
      ),
      home: const MyHomePage(title: 'Minha aplicação em Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Candidate> candidates = Candidate.candidates();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          final candidate = candidates[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: Colors.blue[100],
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[200],
                child: Text(candidate.name[0]),
              ),
              title: Text(candidate.name),
              subtitle: Text(candidate.email),
              trailing: Icon(
                candidate.available ? Icons.check : Icons.close,
                color: candidate.available ? Colors.green : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
