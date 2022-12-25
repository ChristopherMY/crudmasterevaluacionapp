import 'package:crudmasterevaluacion/clean_architecture/domain/repository/employee_repository.dart';
import 'package:crudmasterevaluacion/clean_architecture/presentation/provider/employee/components/employee_form.dart';
import 'package:crudmasterevaluacion/clean_architecture/presentation/provider/employee/employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen._({Key? key}) : super(key: key);

  static Widget init(BuildContext context, bool isUpdated, String employeeId) {
    return ChangeNotifierProvider<EmployedBloc>(
      create: (context) => EmployedBloc(
        employeeInterface: context.read<EmployeeInterface>(),
      )
        ..isUpdated = isUpdated
        ..employeeId = employeeId,
      builder: (context, child) => const EmployeeScreen._(),
    );
  }

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  void initEmployed() async {
    final employedBloc = context.read<EmployedBloc>();
    if (employedBloc.isUpdated) {
      await employedBloc.findEmployee(context: context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    initEmployed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final employedBloc = context.read<EmployedBloc>();
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: Text(employedBloc.isUpdated
              ? "Actualizar Empleado"
              : "Nuevo Empleado"),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: EmployeeForm(),
        ),
      ),
    );
  }
}
