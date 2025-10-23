import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_moastafa_akkam/auth/repo/auth_bloc/auth_bloc.dart';
import 'package:task_moastafa_akkam/auth/repo/auth_bloc/auth_event.dart';
import 'package:task_moastafa_akkam/auth/repo/auth_bloc/auth_state.dart';
import 'package:task_moastafa_akkam/product/screens/products_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = GoogleFonts.poppinsTextTheme(theme.textTheme);

    // Use the root AuthBloc provided by MultiBlocProvider in main.dart
    return Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Sign Up',
              style:
                  textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              return Center(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isWide ? 460 : double.infinity,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 24,
                            offset: Offset(0, 12),
                          ),
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 28),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Create Account',
                              style: textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            _LabeledField(
                              label: 'Name',
                              child: TextField(
                                controller: _nameController,
                                textCapitalization: TextCapitalization.words,
                                decoration: const InputDecoration(
                                  hintText: 'Mostafa Akkam',
                                  prefixIcon: Icon(Icons.person_outline),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _LabeledField(
                              label: 'Email',
                              child: TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: 'you@gmail.com',
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _LabeledField(
                              label: 'Password',
                              child: _PasswordField(
                                  controller: _passwordController),
                            ),
                            const SizedBox(height: 16),
                            _LabeledField(
                              label: 'Confirm Password',
                              child: _PasswordField(
                                  controller: _confirmController),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  if (state.authStatus == Status.success) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const ProductsScreen()),
                                      (route) => false,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state.authStatus == Status.loading) {
                                    return const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: FittedBox(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  return ElevatedButton(
                                    onPressed: () {
                                      context.read<AuthBloc>().add(
                                            RegisterEvent(
                                              password: _passwordController.text,
                                              email: _emailController.text,
                                              username: _nameController.text,
                                              id: 555,
                                            ),
                                          );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      elevation: 6,
                                      shadowColor: Colors.black.withOpacity(0.3),
                                    ),
                                    child: const Text(
                                      'Create Account',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFFF6F8FB),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: child,
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const _PasswordField({required this.controller});

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      decoration: InputDecoration(
        hintText: '••••••••',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(_obscure
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined),
        ),
        border: InputBorder.none,
      ),
    );
  }
}
