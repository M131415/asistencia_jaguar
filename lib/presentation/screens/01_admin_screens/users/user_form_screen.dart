import 'dart:developer';

import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/data/models/career_model.dart';
import 'package:asistencia_jaguar/data/models/user_admin.dart';
import 'package:asistencia_jaguar/data/models/user_student.dart';
import 'package:asistencia_jaguar/data/models/user_teacher.dart';
import 'package:asistencia_jaguar/domain/entities/user.dart';
import 'package:asistencia_jaguar/presentation/providers/career_p/career_provider.dart';
import 'package:asistencia_jaguar/presentation/providers/user_p/user_provider.dart';
import 'package:asistencia_jaguar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFormScreen extends ConsumerStatefulWidget {
  final User? user;
  const UserFormScreen({super.key, this.user});

  @override
  ConsumerState<UserFormScreen> createState() => _UserFormCreateScreenState();
}

class _UserFormCreateScreenState extends ConsumerState<UserFormScreen> {

  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _rolController = TextEditingController();
  final _academicDegreeController = TextEditingController();
  final _careerController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? selectedRol;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      isEditing = true;
      _initializeControllers();
    }
  }

  void _initializeControllers() {
    final user = widget.user!;
    _userNameController.text = user.username;
    _emailController.text = user.email;
    _nameController.text = user.name;
    _lastNameController.text = user.lastName;
    _rolController.text = user.rol.toSpanish();
    selectedRol = user.rol.toSpanish();

    if (user is UserTeacher) {
      _academicDegreeController.text = user.teacherProfile.degree;
    } else if (user is UserStudent) {
      _careerController.text = user.studentProfile.carrer.id.toString();
    }
  }

  @override
  Widget build(BuildContext context) {

    final appRouter = ref.watch(appRouterProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Editar Usuario' : 'Crear Usuario'),
          actions: isEditing 
          ? null
          : [
              IconButton(
                icon: const Icon(Icons.group_add_rounded),
                onPressed: () {
                  appRouter.pushNamed(
                    Routes.adminUserListFromCSV.name
                  );
                }
              ),
            ]
          
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomDropdown(
                  icon: Icons.person,
                  title: 'Rol',
                  controller: _rolController,
                  items: UserRol.values.map((rol) => rol.toSpanish()).where((rol) => rol != 'Sin rol').toList(),
                  isFirstValueByDefault: false,
                  isOnChangeEnabled: isEditing ? false : true,
                  defaultIndex: isEditing
                              ? UserRol.values.indexWhere((rol) => rol == widget.user?.rol)
                              : 0,
                  onChanged: (value) {
                    setState(() {
                      selectedRol = value;
                      log('Rol seleccionado: $selectedRol');
                    });
                  },
                ),

                TextInput(
                  icon: Icons.account_circle_rounded,
                  title: 'Nombre de usuario', 
                  placeholder: 'RFC o No. de control',
                  controller: _userNameController
                ),
                
                TextInput(
                  icon: Icons.email, 
                  title: 'Email', 
                  placeholder: 'jaguar@chilpancingo.tecnm.mx',
                  controller: _emailController
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: TextInput(
                      title: 'Nombre(s)', 
                      placeholder: 'Joven', 
                      controller: _nameController
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextInput(
                      title: 'Apellidos', 
                      placeholder: 'Ilustre Sincero', 
                      controller: _lastNameController,
                      ),
                    ),
                  ],
                ),

                // Campos adicionales según el rol
                if (selectedRol == 'Docente') ...[
                  TextInput(
                    icon: Icons.school,
                    title: 'Grado Académico',
                    placeholder: 'Doctor en Ciencias Computacionales',
                    controller: _academicDegreeController
                  ),
                ],

                if (selectedRol == 'Estudiante') ...[
                
                ref.watch(careerStateProvider).when(
                    data: (careers) {
                    
                    final careerMap = {
                      for (var career in careers)
                      career.shortName: career.id
                    };

                                       
                    return CustomDropdown(
                      icon: Icons.school,
                      title: 'Carrera',
                      placeholder: 'Selecciona una carrera',
                      controller: _careerController,
                      items: careerMap.keys.toList(),
                      isFirstValueByDefault: false,
                      defaultIndex: isEditing 
                        ? careerMap.values.toList().indexOf(int.parse(_careerController.text))
                        : null,
                      onChanged: (value) {
                        setState(() {
                          _careerController.text = careerMap[value].toString();
                        });
                        
                      },
                    );
                    },
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stackTrace) => Text('Error: $error'),
                ),
                ],

                const SizedBox(height: 16),
                CustomButtom(
                  width: 400,
                  height: 70,
                  icon: Icons.person,
                  label: isEditing ? 'Actualizar usuario' : 'Crear usuario', 
                  onPressed: () async{
                   if (_formKey.currentState!.validate()){
                    final rol = UserRol.fromString(_rolController.text);
                    late User newUser;

                    // Crear el usuario con el mismo constructor pero manteniendo el ID si está editando
                    final int userId = isEditing ? widget.user!.id : 0;

                    log('carrera value: ${_careerController.text}');
                    if (rol == UserRol.admin){
                      newUser = UserAdmin(
                        id: userId,
                        username: _userNameController.text,
                        name: _nameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        image: '',
                        rol: rol,
                      );
                    } else if (rol == UserRol.teacher) {
                      newUser = UserTeacher(
                        id: userId,
                        username: _userNameController.text,
                        name: _nameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        image: '',
                        rol: rol,
                        teacherProfile: TeacherProfile(
                          id: 0,
                          degree: _academicDegreeController.text,
                        ),
                      );
                    } else if (rol == UserRol.student) {
                      newUser = UserStudent(
                        id: userId,
                        username: _userNameController.text,
                        name: _nameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        image: '',
                        rol: rol,
                        studentProfile: StudentProfile(
                          id: 0,
                          carrer: CareerModel(
                            id: int.parse(_careerController.text), 
                            code: '', 
                            name: '', 
                            shortName: '', 
                            specialty: ''
                          ),
                        ),
                      );
                    }
                    
                    // Llamar al provider para crear o actualizar
                    final result = isEditing 
                      ? await ref.read(userNotifierProvider.notifier).updateUser(newUser.id, newUser)
                      : await ref.read(userNotifierProvider.notifier).createUser(newUser);

                    if (result) {
                      appRouter.pop();
                      if (context.mounted){
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                            content: Text(isEditing ? 'Usuario actualizado' : 'Usuario creado'),
                            duration: const Duration(seconds: 3),
                          )
                        );
                      }
                    } else {
                      if (context.mounted){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isEditing ? 'Error al actualizar' : 'Error al crear'),
                            duration: const Duration(seconds: 3),
                          )
                        );
                      }
                    }
                  }
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}