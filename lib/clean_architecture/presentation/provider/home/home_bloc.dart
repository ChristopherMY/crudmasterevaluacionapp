import 'package:crudmasterevaluacion/clean_architecture/domain/model/employee_model.dart';
import 'package:crudmasterevaluacion/clean_architecture/domain/repository/employee_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomeBloc extends ChangeNotifier {
  final EmployeeInterface employeeInterface;

  HomeBloc({required this.employeeInterface});

  List<Employee> employees = [];

  void loadEmployees(BuildContext context) async {
    employees = await getEmployees(context);
    notifyListeners();
  }

  Future<List<Employee>> getEmployees(BuildContext context) async {
    context.loaderOverlay.show();
    final response = await employeeInterface.getEmployees();

    if (response.data == null) {
      context.loaderOverlay.hide();
      return [];
    }

    final data =
        (response.data as List).map((x) => Employee.fromMap(x)).toList();

    if (data.isNotEmpty) {
      return data;
    }

    return [];
  }

  void deleteEmployed({required String employedId}) async{

    final response = await employeeInterface.getEmployees();

    if (response.data == null) {
      context.loaderOverlay.hide();
      return;
    }
  }
}
