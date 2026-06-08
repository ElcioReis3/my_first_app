import 'package:flutter/material.dart';
import 'package:my_first_app/provider/candidate_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/models/candidate.dart';

class EditCandidateScreen extends StatefulWidget {
  final int candidateIndex;
  final Candidate candidate;

  const EditCandidateScreen({
    super.key,
    required this.candidateIndex,
    required this.candidate,
  });

  @override
  State<EditCandidateScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<EditCandidateScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _documentController;
  late final TextEditingController _emailController;
  late final TextEditingController _courseController;
  late final TextEditingController _graduationYearController;

  late bool _available;
  DateTime? _selectedDate;

  late List<String> _technicalSkills;
  late List<String> _softSkills;
  final _techSkillController = TextEditingController();
  final _softSkillController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final c = widget.candidate;
    _nameController = TextEditingController(text: c.name);
    _documentController = TextEditingController(text: c.document);
    _emailController = TextEditingController(text: c.email);
    _courseController = TextEditingController(text: c.course);
    _graduationYearController = TextEditingController(
      text: c.graduationYear.toString(),
    );
    _available = c.available;
    _technicalSkills = List.from(c.technicalSkills);
    _softSkills = List.from(c.softSkills);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _documentController.dispose();
    _emailController.dispose();
    _courseController.dispose();
    _graduationYearController.dispose();
    _techSkillController.dispose();
    _softSkillController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(widget.candidate.graduationYear),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF3A7BD5),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF1E3A5F),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _graduationYearController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _addSkill(List<String> list, TextEditingController controller) {
    final value = controller.text.trim();
    if (value.isNotEmpty) {
      setState(() {
        list.add(value);
        controller.clear();
      });
    }
  }

  void _removeSkill(List<String> list, int index) {
    setState(() => list.removeAt(index));
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updated = Candidate(
        name: _nameController.text.trim(),
        document: _documentController.text.trim(),
        email: _emailController.text.trim(),
        course: _courseController.text.trim(),
        graduationYear: _selectedDate?.year ?? widget.candidate.graduationYear,
        available: _available,
        technicalSkills: List.from(_technicalSkills),
        softSkills: List.from(_softSkills),
      );

      context.read<CandidateProvider>().updateCandidate(
        widget.candidateIndex,
        updated,
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A5F),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Editar Candidato",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Seção: Dados Pessoais
              _sectionCard(
                title: "Dados Pessoais",
                icon: Icons.person_outline,
                children: [
                  _buildField(
                    controller: _nameController,
                    label: "Nome completo",
                    icon: Icons.badge_outlined,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Informe o nome" : null,
                  ),
                  const SizedBox(height: 12),
                  _buildField(
                    controller: _documentController,
                    label: "Documento",
                    icon: Icons.article_outlined,
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Informe o documento" : null,
                  ),
                  const SizedBox(height: 12),
                  _buildField(
                    controller: _emailController,
                    label: "E-mail",
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Informe o e-mail";
                      if (!v.contains('@')) return "E-mail inválido";
                      return null;
                    },
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Seção: Formação
              _sectionCard(
                title: "Formação",
                icon: Icons.school_outlined,
                children: [
                  _buildField(
                    controller: _courseController,
                    label: "Curso",
                    icon: Icons.menu_book_outlined,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Informe o curso" : null,
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _pickDate,
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _graduationYearController,
                        validator: (v) => v == null || v.isEmpty
                            ? "Selecione a data de formatura"
                            : null,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1E3A5F),
                        ),
                        decoration: InputDecoration(
                          labelText: "Data de formatura",
                          labelStyle: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF718096),
                          ),
                          prefixIcon: const Icon(
                            Icons.calendar_today_outlined,
                            size: 18,
                            color: Color(0xFF3A7BD5),
                          ),
                          suffixIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFF3A7BD5),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF7FAFC),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFCBD5E0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFCBD5E0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF3A7BD5),
                              width: 1.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFE53E3E),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Disponível para contratação",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF4A5568),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Switch(
                        value: _available,
                        onChanged: (val) => setState(() => _available = val),
                        activeThumbColor: const Color(0xFF3A7BD5),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Habilidades Técnicas
              _skillsCard(
                title: "Habilidades Técnicas",
                icon: Icons.code_outlined,
                skills: _technicalSkills,
                controller: _techSkillController,
                tagColor: const Color(0xFFEBF4FF),
                tagTextColor: const Color(0xFF2B6CB0),
                onAdd: () => _addSkill(_technicalSkills, _techSkillController),
                onRemove: (i) => _removeSkill(_technicalSkills, i),
              ),

              const SizedBox(height: 12),

              // Características Pessoais
              _skillsCard(
                title: "Características Pessoais",
                icon: Icons.psychology_outlined,
                skills: _softSkills,
                controller: _softSkillController,
                tagColor: const Color(0xFFF0F4FF),
                tagTextColor: const Color(0xFF3730A3),
                onAdd: () => _addSkill(_softSkills, _softSkillController),
                onRemove: (i) => _removeSkill(_softSkills, i),
              ),

              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text(
                  "Salvar Alterações",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A7BD5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                label: const Text(
                  "Cancelar",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF4A5568),
                  side: const BorderSide(color: Color(0xFFCBD5E0)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF3A7BD5)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E3A5F),
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Divider(color: Color(0xFFE2E8F0)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 13, color: Color(0xFF1E3A5F)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 13, color: Color(0xFF718096)),
        prefixIcon: Icon(icon, size: 18, color: const Color(0xFF3A7BD5)),
        filled: true,
        fillColor: const Color(0xFFF7FAFC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFCBD5E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFCBD5E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF3A7BD5), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE53E3E)),
        ),
      ),
    );
  }

  Widget _skillsCard({
    required String title,
    required IconData icon,
    required List<String> skills,
    required TextEditingController controller,
    required Color tagColor,
    required Color tagTextColor,
    required VoidCallback onAdd,
    required void Function(int) onRemove,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF3A7BD5)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E3A5F),
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Divider(color: Color(0xFFE2E8F0)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF1E3A5F),
                  ),
                  onFieldSubmitted: (_) => onAdd(),
                  decoration: InputDecoration(
                    hintText: "Adicionar...",
                    hintStyle: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFFADB5BD),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF7FAFC),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFCBD5E0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFCBD5E0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFF3A7BD5),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: onAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A7BD5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(12),
                  minimumSize: const Size(44, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(Icons.add, size: 20),
              ),
            ],
          ),
          if (skills.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: skills.asMap().entries.map((entry) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: tagColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        entry.value,
                        style: TextStyle(
                          fontSize: 11,
                          color: tagTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => onRemove(entry.key),
                        child: Icon(Icons.close, size: 13, color: tagTextColor),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
