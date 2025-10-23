import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_moastafa_akkam/auth/repo/auth_bloc/auth_bloc.dart';
import 'package:task_moastafa_akkam/auth/repo/auth_bloc/auth_state.dart';
import 'package:task_moastafa_akkam/auth/repo/auth_bloc/auth_event.dart';
import 'package:task_moastafa_akkam/auth/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = GoogleFonts.poppinsTextTheme(theme.textTheme);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Profile', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final user = state.user;
            final displayName = (user?.username?.isNotEmpty ?? false) ? user!.username! : 'Guest';
            final displayEmail = (user?.email?.isNotEmpty ?? false) ? user!.email! : 'no-email@unknown';
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 44,
                      backgroundColor: const Color(0xFFE9EEF6),
                      child: const Icon(Icons.person_outline, size: 44),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person, color: Colors.black87),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email, color: Colors.black54),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          displayEmail,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        context.read<AuthBloc>().add(LogoutEvent());
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFD32F2F), // red tone
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
