import 'package:crudmasterevaluacion/clean_architecture/domain/model/employee_model.dart';
import 'package:crudmasterevaluacion/clean_architecture/helper/http_response.dart';

abstract class EmployeeInterface {
  Future<HttpResponse> getEmployees();

  Future<HttpResponse> addEmployee({
    required Employee employee,
  });

  Future<HttpResponse> findEmployee({
    required String employeeId,
  });

  Future<HttpResponse> updateEmployee({
    required Employee employee,
  });

  Future<HttpResponse> deleteEmployee({
    required String employeeId,
  });
}
