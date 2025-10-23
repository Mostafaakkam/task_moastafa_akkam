import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/screens/login_screen.dart';
import 'product/repo/product_bloc/product_bloc.dart';
import 'product/repo/product_repo.dart';
import 'auth/repo/auth_bloc/auth_bloc.dart';
import 'auth/repo/auth_repo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      useMaterial3: true,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductBloc(ProductRepo())),
        BlocProvider(create: (_) => AuthBloc(AuthRepo())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Auth UI',
        theme: baseTheme.copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
