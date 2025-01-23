import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final IconData icon;
  final String title;
  final TextEditingController controller;
  final List<String> items;
  final Function(String?)? onChanged; // Añadido nuevo parámetro
  final bool isFirstValueByDefault;
  final int? defaultIndex;
  final String placeholder;
  final bool isOnChangeEnabled;

  const CustomDropdown({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
    required this.items,
    this.onChanged, // Parámetro opcional
    this.isFirstValueByDefault = true,
    this.placeholder = '',
    this.defaultIndex,
    this.isOnChangeEnabled = true,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.items.isNotEmpty) {
      if(widget.isFirstValueByDefault){
        _selectedValue = widget.items.first;
        widget.controller.text = _selectedValue ?? '';
      } else if (widget.defaultIndex != null && widget.defaultIndex! < widget.items.length) {
        _selectedValue = widget.items[widget.defaultIndex!];
        widget.controller.text = _selectedValue ?? '';
      }
    }
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
            style: Theme.of(context).textTheme.bodyLarge,
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
            ],
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedValue,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 10),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              prefixIcon: Icon(widget.icon, color: widget.isOnChangeEnabled ? null : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),),
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              ),
            ),
            items: widget.items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: widget.isOnChangeEnabled 
                                         ? null 
                                         : TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3)
                )),
              );
            }).toList(),
            onChanged: widget.isOnChangeEnabled 
              ? (String? newValue) {
              
                setState(() {
                  _selectedValue = newValue;
                  widget.controller.text = newValue ?? '';
                });
                // Llamar a la función onChanged si está definida
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              
            } : null,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Este campo es obligatorio";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
      ],
    );
  }
}