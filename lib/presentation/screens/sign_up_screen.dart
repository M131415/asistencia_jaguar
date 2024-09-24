import 'package:asistencia_jaguar/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _nameCtrl            = TextEditingController();
  final _emailCtrl           = TextEditingController();
  final _passwordCtrl        = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

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
                _name(),
                _email(),
                const SizedBox(height: 10,),
                _password(),
                _comfirmPassword(),
                const SizedBox(height: 10,),
                _login(context),
                const SizedBox(height: 20,),
                TextButton(
                  onPressed: () {context.goNamed('signIn');}, 
                  child: const Text('Ingresa aquí')
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
      height: 150,
      child: Center(
        child: Text(
          'Conviertete en un \n Docente Jaguar 🐆',
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
      controller: _emailCtrl
    );
  }

  Widget _name() {
    return TextInput(
      icon: Icons.person, 
      title: 'Nombre Completo', 
      placeholder: 'Nombre completo', 
      controller: _nameCtrl
    );
  }

  Widget _password() {
    return TextInput(
      icon: Icons.lock_outline_sharp, 
      title: 'Cotraseña', 
      placeholder: '******', 
      controller: _passwordCtrl,
      isPassword: true,
    );
  }

  Widget _comfirmPassword() {
    return TextInput(
      icon: Icons.lock, 
      title: 'Confirmar cotraseña', 
      placeholder: '******', 
      controller: _confirmPasswordCtrl,
      isPassword: true,
    );
  }

  Widget _login(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(0, 68, 169, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: (){
        // bloc
      },
      child: const Text(
        "Registrar",
        style: TextStyle(
        color: Colors.white
        ),),
    );
  }
}