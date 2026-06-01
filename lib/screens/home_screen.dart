import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/models/candidate.dart';
import 'package:my_first_app/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<HomeScreen> {
  List<Candidate> candidates = Candidate.candidates();
  final Set<int> _expandedTech = {};
  final Set<int> _expandedSoft = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A5F),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Candidatos",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          final candidate = candidates[index];
          final bool isAvailable = candidate.available;
          final bool techExpanded = _expandedTech.contains(index);
          final bool softExpanded = _expandedSoft.contains(index);

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isAvailable
                    ? const Color(0xFF3A7BD5)
                    : const Color(0xFFCBD5E0),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: isAvailable
                            ? const Color(0xFF3A7BD5)
                            : const Color(0xFF90A4AE),
                        child: Text(
                          candidate.name[0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              candidate.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                color: Color(0xFF1E3A5F),
                              ),
                            ),
                            Text(
                              candidate.email,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF718096),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isAvailable
                              ? const Color(0xFFE8F4FD)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isAvailable
                                ? const Color(0xFF3A7BD5)
                                : const Color(0xFFCBD5E0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isAvailable
                                  ? Icons.check_circle_outline
                                  : Icons.cancel_outlined,
                              size: 13,
                              color: isAvailable
                                  ? const Color(0xFF3A7BD5)
                                  : const Color(0xFF90A4AE),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isAvailable ? "Disponível" : "Indisponível",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isAvailable
                                    ? const Color(0xFF3A7BD5)
                                    : const Color(0xFF90A4AE),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  const SizedBox(height: 8),

                  // Habilidades Técnicas expansível
                  _expandableSection(
                    label: "Habilidades Técnicas",
                    count: candidate.technicalSkills.length,
                    isExpanded: techExpanded,
                    onTap: () => setState(() {
                      techExpanded
                          ? _expandedTech.remove(index)
                          : _expandedTech.add(index);
                    }),
                    skills: candidate.technicalSkills,
                    tagColor: const Color(0xFFEBF4FF),
                    tagTextColor: const Color(0xFF2B6CB0),
                  ),

                  const SizedBox(height: 4),

                  // Características Pessoais expansível
                  _expandableSection(
                    label: "Características Pessoais",
                    count: candidate.softSkills.length,
                    isExpanded: softExpanded,
                    onTap: () => setState(() {
                      softExpanded
                          ? _expandedSoft.remove(index)
                          : _expandedSoft.add(index);
                    }),
                    skills: candidate.softSkills,
                    tagColor: const Color(0xFFF0F4FF),
                    tagTextColor: const Color(0xFF3730A3),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.createCandidate);
        },
        tooltip: "Criar candidato",
        backgroundColor: const Color(0xFF3A7BD5),
        foregroundColor: Colors.white,
        child: const Icon(Icons.person_add),
      ),
    );
  }

  Widget _expandableSection({
    required String label,
    required int count,
    required bool isExpanded,
    required VoidCallback onTap,
    required List<String> skills,
    required Color tagColor,
    required Color tagTextColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A5568),
                    fontFamily: "Poppins",
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: tagColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "$count",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: tagTextColor,
                    ),
                  ),
                ),
                const Spacer(),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: tagTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 4),
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: skills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: tagColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      fontSize: 11,
                      color: tagTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
