import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {

  List<List<dynamic>> _data = [['lll', 'kkkk']]; 
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Grupo', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Importar alumnos'),
          Expanded(
            child: ListView.builder( 
              itemCount: _data.length, 
              itemBuilder: (_, index) { 
                return ListTile( 
                  title: Text(_data[index].join(', ')),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: getData, 
            child: const Text('importar alumnos desde csv')
          ),
        ],
      ),
    );
  }

  void getData() async{
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              allowMultiple: false,
              type: FileType.custom,
              allowedExtensions: ['csv', 'xlsx'],
            );
  
            if (result == null) return; 
              filePath = result.files.single.path!; 
              final input = File(filePath!).openRead(); 
              final fields = await input .transform(utf8.decoder) .transform(const CsvToListConverter()) .toList(); 
              setState(() { _data = fields; }); 
          }
}