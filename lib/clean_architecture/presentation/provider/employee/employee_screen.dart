import 'package:crudmasterevaluacion/clean_architecture/domain/repository/employee_repository.dart';
import 'package:crudmasterevaluacion/clean_architecture/presentation/provider/employee/components/employee_form.dart';
import 'package:crudmasterevaluacion/clean_architecture/presentation/provider/employee/employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen._({Key? key, required this.isUpdate}) : super(key: key);

  final bool isUpdate;

  static Widget init(BuildContext context, bool isUpdate){
    return ChangeNotifierProvider<EmployedBloc>(
      create: (context) => EmployedBloc(employeeInterface: context.read<EmployeeInterface>()),
      builder: (context, child) => EmployeeScreen._(isUpdate: isUpdate),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Actualizar Empleado" : "Nuevo Empleado"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            EmployeeForm()
          ],
        ),
      ),
    );
  }
}
