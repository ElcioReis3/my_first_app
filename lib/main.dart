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

            color: candidate.available
                ? const Color.fromARGB(255, 203, 232, 255)
                : Color.fromARGB(255, 238, 238, 238),

            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      child: Text(candidate.name[0]),
                    ),

                    title: Text(candidate.name),
                    subtitle: Text(candidate.email),
                    trailing: Icon(
                      candidate.available
                          ? Icons.check_circle
                          : Icons.cancel_sharp,
                      color: candidate.available ? Colors.green : Colors.red,
                    ),
                  ),

                  const Text(
                    "Habilidades Técnicas",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Wrap(
                    spacing: 4,
                    runSpacing: 2,
                    children: candidate.technicalSkills.map((skill) {
                      return Chip(
                        label: Text(
                          skill,

                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: candidate.available
                            ? const Color.fromARGB(255, 90, 182, 248)
                            : const Color.fromARGB(255, 218, 218, 218),
                        padding: EdgeInsets.all(10),
                      );
                    }).toList(),
                  ),

                  const Text(
                    "Características pessoais",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Wrap(
                    spacing: 4,
                    runSpacing: 2,
                    children: candidate.softSkills.map((skill) {
                      return Chip(
                        label: Text(
                          skill,

                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: candidate.available
                            ? const Color.fromARGB(255, 90, 182, 248)
                            : const Color.fromARGB(255, 218, 218, 218),
                        padding: EdgeInsets.all(10),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
