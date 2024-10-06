import 'package:asistencia_jaguar/domain/entities.dart';
import 'package:asistencia_jaguar/presentation/providers/providers.dart';
import 'package:asistencia_jaguar/presentation/providers/student_list_p/student_list.dart';
import 'package:asistencia_jaguar/widgets/custom_show_add_dialog.dart';
import 'package:asistencia_jaguar/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';

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

  @override
  Widget build(BuildContext context) {

    final toggleButtonsSelection = ref.watch(toggleScheduleProvider);
    final onToggleSchedule = ref.read(toggleScheduleProvider.notifier);

    final currentStep = ref.watch(currentStepProvider);
    final onStepChange = ref.read(currentStepProvider.notifier);

    final subjectList = ref.watch(subjectListProvider);
    final onSubjectChange = ref.read(subjectListProvider.notifier);

    final selectedSub = ref.watch(selectedSubjectProvider);
    final onSelectSub = ref.read(selectedSubjectProvider.notifier);

    final studentList = ref.watch(studentListProvider);
    final onStudentList = ref.read(studentListProvider.notifier); 

    // Controlador para agregar una materia
    final subjectNameCtrl = TextEditingController();

    //Controladores para agregar informacion del grupo
    final groupNameCtrl = TextEditingController();
    final departamentCtrl = TextEditingController();
    final periodCtrl = TextEditingController();

    void onAddNewSubject( String subjectName){
      if (subjectName.length > 1){
        onSubjectChange.addNewSubject(subjectName);
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

        // Paso 1 ELEGIR UNA MATERIA

        Step(
          isActive: currentStep == 0,
          title: const Text('Seleccionar una materia'), 
          content: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: subjectList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final subject = subjectList[index];
                    return ListTile(
                      selected: selectedSub == subject,
                      selectedTileColor: seedColor.withOpacity(0.1),
                      leading: CircleAvatar(child: Text(subject.name.substring(0,2))),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      title: Text(subject.name),
                      onTap: () {
                        if (selectedSub != subject){
                          onSelectSub.onSelectSubject(subject);
                        } else if (selectedSub == subject){
                          final emptySub = Subject(id: '', userId: '', name: '');
                          onSelectSub.onSelectSubject(emptySub);
                        }
                        return;
                      },
                      onLongPress: () {
                        
                      },
                    );
                  },
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.my_library_add_rounded),
                      SizedBox(width: 10,),
                      Text('Agregar nueva materia'),
                    ],
                  ),
                  onPressed: () {
                    addNewSubject();
                  },
                ),
                
              ],
            ),
          ),
        ),

        // Paso 2 AGREGAR INFORMACION DEL GRUPO

        Step(
          isActive: currentStep == 1,
          title: const Text('Información del grupo'),
          content: Column(
            children: [
              TextInput(
                icon: Icons.people, 
                title: 'Nombre del Grupo', 
                placeholder: 'I7A', 
                controller: groupNameCtrl
              ),
              TextInput(
                icon: Icons.business, 
                title: 'Nombre del Departamento', 
                placeholder: 'Departamento de Sistemas y Computación',
                controller: departamentCtrl
              ),
              TextInput(
                icon: Icons.date_range, 
                title: 'Periodo', 
                placeholder: 'AGOSTO-DICIEMBRE/2024',
                controller: periodCtrl
              ),
            ],
          )
        ),

        // Paso 3 Establecer un horario

        Step(
          isActive: currentStep == 2,
          title: const Text('Establecer el horario'), 
          content: Column(
            children: [
              ToggleButtons(
                isSelected: toggleButtonsSelection,
                onPressed: onToggleSchedule.onPressToggle,
                constraints: const BoxConstraints(
                  minHeight: 32,
                  minWidth: 32
                ),
                children: dayOfWeekOptions.map(((DayOfWeek, String) shirt) => Text(shirt.$2)).toList()
              ),
              Row(
                children: [
                  const Text('Establecer un tiempo limite'),
                  Switch.adaptive(
                    value: true, 
                    onChanged: (value) {
                    
                    },
                  ),
                ],
              ),
            ],
          )
        ),

        // Paso 4 AGREGAR ESTUDIANTES

        Step(
          isActive: currentStep == 3,
          title: const Text('Seleccionar estudiantes'),
          content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                ListView.builder( 
                  itemCount: studentList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {

                    final student = studentList[index];

                    return ListTile( 
                      title: Text(student.name),
                      subtitle: Text(student.controlNo),
                      trailing: Text((index+1).toString()),
                      leading: const CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.person),
                      ),
                    );
                  },
                ),
                
                ElevatedButton(
                  onPressed: () {
                    onStudentList.onAddStudentfromList();
                  }, 
                  child: const Text('importar alumnos desde csv')
                ),
              ],
            ),
          ),
      ],
        currentStep: currentStep,
        onStepTapped: (int newIndex) => onStepChange.onStepTapped(newIndex), 
        onStepContinue: () {
          if (selectedSub.name.isNotEmpty){
            onStepChange.onStepContinue();
          }
        },
        onStepCancel: () => onStepChange.onStepCancel(),
      );
  }
}

