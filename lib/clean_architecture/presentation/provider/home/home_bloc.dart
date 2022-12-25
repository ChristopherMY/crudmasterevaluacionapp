import 'package:crudmasterevaluacion/clean_architecture/domain/model/employee_model.dart';
import 'package:crudmasterevaluacion/clean_architecture/domain/repository/employee_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomeBloc extends ChangeNotifier {
  final EmployeeInterface employeeInterface;

  HomeBloc({required this.employeeInterface});

  List<Employee> employees = [];

  void loadEmployees(BuildContext context) async {

    context.loaderOverlay.show();
    employees = await getEmployees();
    context.loaderOverlay.hide();
    notifyListeners();
  }

  Future<List<Employee>> getEmployees() async {
    final response = await employeeInterface.getEmployees();

    if (response.data == null) {
      return [];
    }

    final data =
        (response.data as List).map((x) => Employee.fromMap(x)).toList();

    if (data.isNotEmpty) {
      return data;
    }

    return [];
  }
}
