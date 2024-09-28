import 'package:asistencia_jaguar/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                _email(),
                const SizedBox(height: 10,),
                _password(),
                const SizedBox(height: 50,),
                _login(context),
                const SizedBox(height: 20,),
                TextButton(
                  onPressed: () {context.goNamed('signUp');}, 
                  child: const Text('Registrate aquí')
                ),
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
          'Bienvenido Docente Jaguar 🐆',
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _email() {
    return TextInput(
      icon: Icons.email, 
      title: 'Correo Electrónico', 
      placeholder: 'jaguar@tecnm.mx', 
      controller: _emailController
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

  Widget _login(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 68, 169),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size(double.infinity, 60),
          elevation: 0,
      ),
      onPressed: (){
        
      },
      child: const Text(
        "Ingresar",
        style: TextStyle(
        color: Colors.white
        ),),
    );
  }
}