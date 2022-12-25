import 'package:crudmasterevaluacion/clean_architecture/domain/api/environment.dart';
import 'package:crudmasterevaluacion/clean_architecture/domain/repository/employee_repository.dart';
import 'package:crudmasterevaluacion/clean_architecture/helper/http.dart';
import 'package:crudmasterevaluacion/clean_architecture/helper/http_response.dart';

class EmployeeService implements EmployeeInterface {
  final String _url = Environment.API_DAO;
  final Http _dio = Http(logsEnabled: true);

  @override
  Future<HttpResponse> addEmployee({required Map<String, dynamic> employee}) async {
    return await _dio.request(
      "$_url/api/v1/empleados",
      method: "POST",
      data: employee,
    );
  }

  @override
  Future<HttpResponse> deleteEmployee({
    required String employeeId,
  }) async {
    return await _dio.request(
      "$_url/api/v1/empleados/$employeeId",
      method: "DELETE",
    );
  }

  @override
  Future<HttpResponse> findEmployee({required String employeeId}) async {
    return await _dio.request(
      "$_url/api/v1/empleados/find/$employeeId",
      method: "GET",
    );
  }

  @override
  Future<HttpResponse> getEmployees() async {
    return await _dio.request(
      "$_url/api/v1/empleados/",
      method: "GET",
    );
  }

  @override
  Future<HttpResponse> updateEmployee({
    required Map<String, dynamic> employee,
  }) async {
    return await _dio.request(
      "$_url/api/v1/empleados",
      method: "PUT",
      data: employee,
    );
  }
}
