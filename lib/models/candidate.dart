class Candidate {
  // atributos
  String name;
  String document;
  String email;
  String course;
  int graduationYear;
  bool available;
  List<String> technicalSkills;
  List<String> softSkills;

  //construtor
  Candidate({
    required this.name,
    required this.document,
    required this.email,
    required this.course,
    required this.available,
    required this.graduationYear,
    required this.technicalSkills,
    required this.softSkills,
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
        technicalSkills: [
          "HTML",
          "TAILWINDCSS",
          "JAVASCRIPT",
          "TYPESCRIPT",
          "PHP",
          "REACT",
          "NEXT.JS",
          "NODE.JS",
          "MYSQL",
          "MONGODB",
          "DEPLOY",
          "ASSISTENTE ADMINISTRATIVO",
          "DESIGNER GRÁFICO",
        ],
        softSkills: [
          "Foco em resultados",
          "Proativo",
          "Facilidade em aprender",
          "Pensamento crítico",
          "Busca por inovação",
        ],
      ),

      Candidate(
        name: "Nayra Geovana",
        document: "1234567890",
        email: "naygeovana@gmail.com",
        course: "Técnico em Informática para internet",
        available: true,
        graduationYear: 2026,
        technicalSkills: [
          "HTML",
          "CSS",
          "Javascript",
          "PHP",
          "IA",
          "Informática básica",
          "Recepção",
        ],
        softSkills: ["impaciente", "agilidosa", "competente", "responsável"],
      ),

      Candidate(
        name: "Joao pedro",
        document: "01254125898",
        email: "joaopedro@gmail.com",
        course: "Tecnico em Informatica para Internet",
        graduationYear: 2026,
        available: true,
        technicalSkills: ["HTML", "CSS", "JavaScript", "Java", "PHP", "IA"],
        softSkills: [
          "Proativo",
          "Organização de tarefas",
          "Gestão do tempo",
          "Planejamento",
          "Criatividade",
        ],
      ),

      Candidate(
        name: "Francisco Kassio",
        document: "123456789",
        email: "franciscokassio@example.com",
        course: "Tecnico em Informatica para Internet",
        graduationYear: 2026,
        available: false,
        technicalSkills: ["PHP", "HTML/CSS", "Flutter", "Dart"],
        softSkills: [
          "Comunicação",
          "Resolução de problemas",
          "Adaptação",
          "Liderança",
        ],
      ),

      Candidate(
        name: "Náyla Gabrielle",
        document: "1234567890",
        email: "nayla.gabrielle@ma.senac.br",
        course: "Técnico em Informática para Internet",
        graduationYear: 2026,
        available: true,
        technicalSkills: ["HTML", "CSS", "JAVASCRIPT", "PHP"],
        softSkills: ["Pensamento Crítico", "Adaptabilidade", "Empatia"],
      ),

      Candidate(
        name: "Ezequiel Santos",
        document: "1234567890",
        email: "ezequiel25@gmail.com",
        course: "Técnico em Informática para Internet",
        graduationYear: 2026,
        available: false,
        technicalSkills: [
          "HTML",
          "CSS",
          "Javascript",
          "Tecnico em Recursos Humanos",
        ],
        softSkills: ["Criativo", "Empatia", "Paciente"],
      ),
    ];
  }
}
