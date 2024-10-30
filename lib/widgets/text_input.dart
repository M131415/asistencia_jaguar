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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
            title, 
            style: Theme.of(context).textTheme.bodyLarge
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 20),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                offset: const Offset(0, 5),
                blurRadius: 5,
              )
            ]
          ),
          child: TextFormField(
            validator: _validatorText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboard,
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 10),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              prefixIcon: Icon(icon),
              suffixIcon: isPassword
                ? const Icon(Icons.visibility_off) 
                : null,
              hintText: placeholder,
              hintStyle: const TextStyle(color: Color.fromARGB(208, 158, 158, 158))
            ),
          ),
        ),
      ],
    );
  }
  String? _validatorText(String? value){

    if(value == null || value.trim().isEmpty){
      return "Este campo es obligatorio";
    }
    return null;
  }
}