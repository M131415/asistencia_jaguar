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
                _password(),
                const SizedBox(height: 50,),
                _signIn(context),
                const SizedBox(height: 10,),
                _forgotPassword(context),
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

  Widget _email() {
    return TextInput(
      icon: Icons.person_2_sharp, 
      title: 'Nombre de Usuario', 
      placeholder: 'username', 
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

  Widget _signIn(BuildContext context) {
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
        if(_formKey.currentState!.validate()){
          context.goNamed('home');
        }
      },
      child: const Text(
        "Ingresar",
        style: TextStyle(
        color: Colors.white
        ),),
    );
  }

  Widget _forgotPassword(BuildContext context){
      return Center(
        child: TextButton(
          onPressed: () {}, 
          child: const Text('¿Olvidó su contraseña?')
        ),
      );
    }
}