import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final IconData icon;
  final String title;
  final String placeholder;
  final TextEditingController controller;
  final TextInputType keyboard;
  final bool isPassword;

  const TextInput({
    super.key, 
    required this.icon, 
    required this.title,
    required this.placeholder, 
    required this.controller, 
    this.keyboard = TextInputType.text, 
    this.isPassword = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 5),
            blurRadius: 5,
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(title, style: const TextStyle(
              fontSize: 15,
            ),),
          ),
          TextFormField(
            validator: _validatorText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboard,
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              prefixIcon: Icon(icon),
              hintText: placeholder,
              hintStyle: const TextStyle(color: Color.fromARGB(208, 158, 158, 158))
            ),
          ),
        ],
      ),
    );
  }
  String? _validatorText(String? value){

    if(value == null || value.trim().isEmpty){
      return "Este campo es obligatorio";
    }
    return null;
  }
}