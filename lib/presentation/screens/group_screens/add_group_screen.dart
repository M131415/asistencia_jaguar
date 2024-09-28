import 'dart:convert';
import 'dart:io';

import 'package:asistencia_jaguar/domain/entities/student_entity.dart';
import 'package:asistencia_jaguar/presentation/providers/providers.dart';
import 'package:asistencia_jaguar/widgets/custom_show_add_dialog.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DayOfWeek {monday, tuesday, wendsday, thursday, friday, saturday, sunday}

class AddGroupScreen extends StatelessWidget {
  const AddGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Grupo', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: const StepView()
    );
  }
}

class StepView extends ConsumerStatefulWidget {
  const StepView({super.key});

  @override
  StepViewState createState() => StepViewState();
}

class StepViewState extends ConsumerState<StepView> {

  late List<StudentEntity> _data = [];
  String? filePath;

  @override
  Widget build(BuildContext context) {

    final subjectList = ref.watch(subjectListProvider);
    final subjectChange = ref.read(subjectListProvider.notifier);

    final currentStep = ref.watch(currentStepProvider);
    final stepOnChance = ref.read(currentStepProvider.notifier);

    final subjectNameCtrl = TextEditingController();

    void onAddNewSubject( String subjectName){
    if (subjectName.length > 1){
      subjectChange.addNewSubject(subjectName);
      Navigator.pop(context);
    }
  }

    addNewSubject(){
      customShowAddDialog(
        context, 
        'Agregar nueva Materia', 
        TextField(
          controller: subjectNameCtrl,
          decoration: const InputDecoration(label: Text('Nombre de la materia')),
        ), 
        () {
          onAddNewSubject(subjectNameCtrl.text);
        },
      );
    
  }

    return Stepper(
        steps: [
        Step(
          isActive: currentStep == 0,
          title: const Text('Seleccionar materia'), 
          content: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: subjectList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final subject = subjectList[index];
                    return ListTile(
                      leading: Text((index+1).toString()),
                      title: Text(subject.name),
                      onTap: () {
                        
                      },
                    );
                  },
                ),
                
                ElevatedButton(
                  onPressed: () {
                    addNewSubject();
                  }, 
                  child: const Text('Agregar materia'),
                ),
              ],
            ),
          ),
        ),
        Step(
          isActive: currentStep == 1,
          title: const Text('Información del grupo'),
          content: const Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nombre del grupo'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Nombre del departamento'),
              ),
            ],
          )
        ),
        Step(
          isActive: currentStep == 2,
          title: const Text('Establecer un horario'), 
          content: SegmentedButton(
            multiSelectionEnabled: true,
            segments: const [
              ButtonSegment(value: DayOfWeek.monday, icon: Text('lu')),
              ButtonSegment(value: DayOfWeek.tuesday, icon: Text('ma')),
              ButtonSegment(value: DayOfWeek.wendsday, icon: Text('mi')),
              ButtonSegment(value: DayOfWeek.thursday, icon: Text('ju')),
              ButtonSegment(value: DayOfWeek.friday, icon: Text('vi')),
            ], 
            selected: const {DayOfWeek.monday, DayOfWeek.friday}
          )
        ),
        Step(
          isActive: currentStep == 3,
          title: const Text('Agregar estudiantes'),
          content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Importar alumnos'),
                ListView.builder( 
                    itemCount: _data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {

                      final student = _data[index];

                      return ListTile( 
                        title: Text(student.name),
                        subtitle: Text(student.controlNo),
                        trailing: Text(student.plan),
                      );
                    },
                  ),
                
                ElevatedButton(
                  onPressed: () {
                    getData();
                  }, 
                  child: const Text('importar alumnos desde csv')
                ),
              ],
            ),
          ),
      ],
        currentStep: currentStep,
        onStepTapped: (int newIndex) => stepOnChance.onStepTapped(newIndex), 
        onStepContinue: () => stepOnChance.onStepContinue(),
        onStepCancel: () => stepOnChance.onStepCancel(),
      );
  }

  Future<List<StudentEntity>> getData() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['csv', 'xlsx'],
    );

    if (result != null) { 
      filePath = result.files.single.path!; 
      final input = File(filePath!).openRead(); 
      final fields = await input .transform(utf8.decoder) .transform(const CsvToListConverter()) .toList(); 
      setState(() {
        
      });
      _data = StudentEntity.fromCsvTable(fields);
      return _data;
    } else {
      return [];
    }
  }
}

