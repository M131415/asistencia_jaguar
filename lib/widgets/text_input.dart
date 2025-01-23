import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final IconData? icon;
  final String title;
  final String placeholder;
  final TextEditingController controller;
  final TextInputType keyboard;
  final bool isPassword;
  final int? maxLength;
  final bool isRequired;

  const TextInput({
    super.key, 
    this.icon, 
    required this.title,
    required this.placeholder, 
    required this.controller, 
    this.keyboard = TextInputType.text, 
    this.isPassword = false,
    this.isRequired = true,
    this.maxLength
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {

  bool _showPassword = true;  // Agregar variable para controlar visibilidad

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
            widget.title, 
            style: Theme.of(context).textTheme.bodyLarge
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 20),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
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
            validator: widget.isRequired ? _validatorText : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboard,
            controller: widget.controller,
            obscureText: widget.isPassword ? _showPassword : false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 10),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              prefixIcon: widget.icon != null 
                ? Icon(widget.icon)
                : null,
              suffixIcon: widget.isPassword 
                ? IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                : null,
              hintText: widget.placeholder,
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