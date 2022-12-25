import 'package:crudmasterevaluacion/clean_architecture/domain/model/employee_model.dart';
import 'package:crudmasterevaluacion/clean_architecture/domain/repository/employee_repository.dart';
import 'package:crudmasterevaluacion/clean_architecture/helper/constants.dart';
import 'package:crudmasterevaluacion/clean_architecture/helper/http_response.dart';
import 'package:crudmasterevaluacion/clean_architecture/helper/keyboard.dart';
import 'package:crudmasterevaluacion/clean_architecture/presentation/util/global_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EmployedBloc extends ChangeNotifier {
  final EmployeeInterface employeeInterface;

  EmployedBloc({required this.employeeInterface});

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
    required BuildContext context,
  }) async {
    context.loaderOverlay.show();
    final response =
        await employeeInterface.findEmployee(employeeId: employeeId);
    if (response.data == null) {
      GlobalSnackBar.showWarningSnackBar(
          context, "Tuvimos un problema, vuelva a intentarlo mas tarde.");
      context.loaderOverlay.hide();
      return;
    }
    context.loaderOverlay.hide();

    Employee employee = Employee.fromMap(response.data);

    nameController.text = employee.nombre!;
    lastnameController.text = employee.apellido!;
    ageController.text = employee.edad!;
    birthDayController.text = handleFormatDateTime(employee.fechaNacimiento!);
    admissionDateController.text = handleFormatDateTime(employee.fechaIngreso!);
    contractEndDateController.text = handleFormatDateTime(employee.fechaTerminoContrato!);
  }

  String handleFormatDateTime(DateTime dateTime) =>
      "${dateTime.year}-${dateTime.month}-${dateTime.day}";

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
      return null;
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
      return null;
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
      return null;
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
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
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

      if (errors.value.isNotEmpty) {
        GlobalSnackBar.showInfoSnackBarIcon(context, kResponseError);
        return;
      }

      formKey.currentState!.save();
      context.loaderOverlay.show();
      final Map<String, dynamic> employed = {
        "id_empleado": employeeId,
        "nombre": nameController.text,
        "apellido": lastnameController.text,
        "edad": ageController.text,
        "fecha_nacimiento": birthDayController.text,
        "fecha_ingreso": admissionDateController.text,
        "fecha_termino_contrato": contractEndDateController.text,
        "flg_estd": "1"
      };

      final HttpResponse response;
      if (isUpdated) {
        response = await employeeInterface.updateEmployee(employee: employed);
      } else {
        response = await employeeInterface.addEmployee(employee: employed);
      }

      if (response.data == null) {
        print(response.error!.data!);
        GlobalSnackBar.showErrorSnackBarIcon(context, kResponseError);
        context.loaderOverlay.hide();
        return;
      }

      context.loaderOverlay.hide();
      GlobalSnackBar.showInfoSnackBarIcon(
          context, "Los registros fueron guardados correctamente");

      Navigator.of(context).pop();
    }
  }
}
