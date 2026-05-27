class Candidate {
  // atributos
  String name;
  String document;
  String email;
  String course;
  int graduationYear;
  bool available;

  //construtor
  Candidate({
    required this.name,
    required this.document,
    required this.email,
    required this.course,
    required this.available,
    required this.graduationYear,
  });

  static List<Candidate> candidates() {
    return [
      Candidate(
        name: "Elcio Reis",
        document: "1234567890",
        email: "elciof739@gmail.com",
        course: "Técnico em Informática para internet",
        available: true,
        graduationYear: 2026,
      ),

      Candidate(
        name: "Nayra Geovana",
        document: "1234567890",
        email: "naygeovana@gmail.com",
        course: "Técnico em Informática para internet",
        available: true,
        graduationYear: 2026,
      ),

      Candidate(
        name: "João Pedro",
        document: "1234567890",
        email: "joaopedro@gmail.com",
        course: "Técnico em Informática para internet",
        available: true,
        graduationYear: 2026,
      ),

      Candidate(
        name: "Francisco Kassio",
        document: "123456789",
        email: "franciscokassio@example.com",
        course: "Tecnico em Informatica para Internet",
        graduationYear: 2026,
        available: false,
      ),

      Candidate(
        name: "Náyla Gabrielle",
        document: "1234567890",
        email: "nayla.gabrielle@ma.senac.br",
        course: "Técnico em Informática para Internet",
        graduationYear: 2026,
        available: true,
      ),

      Candidate(
        name: "Ezequiel Santos",
        document: "1234567890",
        email: "ezequiel25@gmail.com",
        course: "Técnico em Informática para Internet",
        graduationYear: 2026,
        available: false,
      ),
    ];
  }
}
