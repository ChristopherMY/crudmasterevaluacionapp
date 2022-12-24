import 'package:crudmasterevaluacion/clean_architecture/domain/model/employee_model.dart';
import 'package:crudmasterevaluacion/clean_architecture/domain/repository/employee_repository.dart';
import 'package:crudmasterevaluacion/clean_architecture/helper/constants.dart';
import 'package:crudmasterevaluacion/clean_architecture/helper/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployedBloc extends ChangeNotifier {
  final EmployeeInterface employeeInterface;

  EmployedBloc({required this.employeeInterface});

  late Employee employee;

  ValueNotifier<List<String>> errors = ValueNotifier([]);
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController admissionDateController = TextEditingController();
  TextEditingController contractEndDateController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String employeeId = "0";
  bool isUpdated = false;

  void removeError({required String error}) {
    List<String> values = List.from(errors.value);
    if (values.contains(error)) {
      values.remove(error);
      errors.value = values;
    }
  }

  void addError({required String error}) {
    List<String> values = List.from(errors.value);
    if (!values.contains(error)) {
      values.add(error);
      errors.value = values;
    }
  }

  Future<void> findEmployee({
    required String employeeId,
    required BuildContext context,
  }) async {
    final response =
        await employeeInterface.findEmployee(employeeId: employeeId);
    if (response.data == null) {
      return;
    }

    employee = Employee.fromMap(response.data);
  }

  void onChangeName(String value) {
    if (value.isNotEmpty) {
      removeError(error: kNameNullError);
    }
  }

  String? onValidationName(String? value) {
    if (value!.isEmpty) {
      addError(error: kNameNullError);
      return "";
    }

    return null;
  }

  void onChangeLastName(String value) {
    if (value.isNotEmpty) {
      removeError(error: kLastNameNullError);
    }
  }

  String? onValidationLastName(String? value) {
    if (value!.isEmpty) {
      addError(error: kLastNameNullError);
      return "";
    }

    return null;
  }

  void onChangeAge(String value) {
    if (value.isNotEmpty) {
      removeError(error: kAgeNullError);
    }
  }

  String? onValidationAge(String? value) {
    if (value!.isEmpty) {
      addError(error: kAgeNullError);
      return "";
    }

    return null;
  }

  void onChangeBirthDay(String value) {
    if (value.isNotEmpty) {
      removeError(error: kBirthDayNullError);
    }
  }

  String? onValidationBirthDay(String? value) {
    if (value!.isEmpty) {
      addError(error: kBirthDayNullError);
      return "";
    }

    if (value.isNotEmpty) {
      removeError(error: kBirthDayNullError);
      return "";
    }
    return null;
  }

  void onChangeAdmissionDate(String value) {
    if (value.isNotEmpty) {
      removeError(error: kAdmissionDateNullError);
    }
  }

  String? onValidationAdmissionDate(String? value) {
    if (value!.isEmpty) {
      addError(error: kAdmissionDateNullError);
      return "";
    }


    if (value.isNotEmpty) {
      removeError(error: kAdmissionDateNullError);
      return "";
    }
    return null;
  }

  void onChangeContractEnd(String value) {
    if (value.isNotEmpty) {
      removeError(error: kContractEndNullError);
    }
  }

  String? onValidationContractEnd(String? value) {
    if (value!.isEmpty) {
      addError(error: kContractEndNullError);
      return "";
    }

    if (value.isNotEmpty) {
      removeError(error: kContractEndNullError);
      return "";
    }

    return null;
  }

  Future<String> handleGetDateSelection(
    BuildContext context,
    DateTime initialDate,
  ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      return formattedDate;
    }

    return DateFormat('yyyy-MM-dd').format(initialDate);
  }

  void handleSaveEmployee(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      KeyboardUtil.hideKeyboard(context);

      if (errors.value.isNotEmpty) return;

      formKey.currentState!.save();
      final employed = Employee(
        idEmpleado: "",
        nombre: nameController.text,
        apellido: lastnameController.text,
        edad: ageController.text,
        fechaIngreso: DateTime.parse(admissionDateController.text),
        fechaNacimiento: DateTime.parse(birthDayController.text),
        fechaTerminoContrato: DateTime.parse(contractEndDateController.text),
        flgEstd: "1",
      );

      if (isUpdated) {
        final response =
            await employeeInterface.updateEmployee(employee: employee);
        return;
      }

      final response = await employeeInterface.addEmployee(employee: employee);
      return;
    }
  }
}
