
import 'dart:developer';

import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/data/services/remote/login_api.dart';
import 'package:asistencia_jaguar/data/sources/user_prefreferences.dart';
import 'package:asistencia_jaguar/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});

  @override
  ConsumerState<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  final _usernameController    = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _header(context),
                _username(),
                _password(),
                const SizedBox(height: 50,),
                _signIn(context, ref),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  SizedBox _header(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Text(
          'Bienvenido Jaguar \n 🐆',
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _username() {
    return TextInput(
      icon: Icons.person_2_sharp, 
      title: 'Nombre de Usuario', 
      placeholder: 'RFC o No. de Control', 
      controller: _usernameController
    );
  }

  Widget _password() {
    return TextInput(
      icon: Icons.lock, 
      title: 'Cotraseña', 
      placeholder: '******', 
      controller: _passwordController,
      isPassword: true,
    );
  }

  Widget _signIn(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 68, 169),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size(double.infinity, 60),
          elevation: 0,
      ),
      onPressed: _handleLogin,
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white,)
          : const Text(
            'Iniciar Sesión',
            style: TextStyle(color: Colors.white),
            ),
      );
  }

  Future<void> _handleLogin() async {

    final loginService = LoginService();
    final appRouter = ref.watch(appRouterProvider);

    setState(() {
      _isLoading = true;
    });

    final result = await loginService.authenticate(
      _usernameController.text,
      _passwordController.text,
    );

    result.when(
      left: (failure) {
        setState(() {
          _isLoading = false;
        });
        // Mostrar un snackbar con el error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: failure.statusCode == 400 
              ? const Text('Nombre de usuario o contraseña incorrectos') 
              : Text(failure.message),
            backgroundColor: Theme.of(context).buttonTheme.colorScheme?.error,
          ),
        );
      },
      right: (loginModel) {

        String location = UserPreferences().defaultRoute;
        log('Default route in right: $location');
        setState(() {
          _isLoading = false;
        });
        appRouter.go(location);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Inicio de sesión exitoso'),
            backgroundColor: Theme.of(context).buttonTheme.colorScheme?.primary,
          ),
        );

      },
    );
  }
}
    