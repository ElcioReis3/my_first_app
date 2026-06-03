import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  // Credenciais fixas para protótipo
  static const String _validEmail = "admin@recrutamento.com";
  static const String _validPassword = "123456";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simula delay de requisição
    await Future.delayed(const Duration(seconds: 1));

    if (_emailController.text.trim() == _validEmail &&
        _passwordController.text == _validPassword) {
      if (mounted) context.go(AppRoutes.home);
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = "E-mail ou senha incorretos.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),

              // Logo / ícone
              Container(
                alignment: Alignment.center,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A5F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.work_outline_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Título
              const Text(
                "Bem-vindo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins",
                  color: Color(0xFF1E3A5F),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Faça login para acessar o sistema",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xFF718096)),
              ),

              const SizedBox(height: 40),

              // Formulário
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Campo e-mail
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1E3A5F),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return "Informe o e-mail";
                        if (!v.contains('@')) return "E-mail inválido";
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        labelStyle: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF718096),
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          size: 18,
                          color: Color(0xFF3A7BD5),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFCBD5E0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFCBD5E0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF3A7BD5),
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFE53E3E),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Campo senha
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1E3A5F),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return "Informe a senha";
                        if (v.length < 6)
                          return "A senha deve ter ao menos 6 caracteres";
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF718096),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          size: 18,
                          color: Color(0xFF3A7BD5),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 18,
                            color: const Color(0xFF718096),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFCBD5E0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFCBD5E0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF3A7BD5),
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFE53E3E),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Mensagem de erro
                    if (_errorMessage != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF5F5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE53E3E)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 16,
                              color: Color(0xFFE53E3E),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _errorMessage!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFFE53E3E),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 24),

                    // Botão entrar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3A7BD5),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(
                            0xFF3A7BD5,
                          ).withOpacity(0.6),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Entrar",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Dica de credenciais (remover em produção)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF4FF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFBEE3F8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Credenciais de acesso (protótipo)",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2B6CB0),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "E-mail: admin@recrutamento.com\nSenha: 123456",
                      style: TextStyle(fontSize: 11, color: Color(0xFF2B6CB0)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
