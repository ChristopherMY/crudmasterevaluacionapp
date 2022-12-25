import 'package:crudmasterevaluacion/clean_architecture/helper/size_config.dart';
import 'package:crudmasterevaluacion/clean_architecture/presentation/provider/employee/employee_bloc.dart';
import 'package:crudmasterevaluacion/clean_architecture/presentation/provider/home/home_bloc.dart';
import 'package:crudmasterevaluacion/clean_architecture/presentation/widget/default_button.dart';
import 'package:crudmasterevaluacion/clean_architecture/presentation/widget/form_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({Key? key}) : super(key: key);

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    final employedBloc = context.read<EmployedBloc>();

    return Form(
      key: employedBloc.formKey,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: employedBloc.nameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: employedBloc.onChangeName,
            validator: employedBloc.onValidationName,
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              labelText: "Nombre",
              hintText: "Ingresa tu nombre",
              labelStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              hintStyle: Theme.of(context).textTheme.bodyText2,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              errorStyle: const TextStyle(height: 0.0),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(25.0)),
          TextFormField(
            controller: employedBloc.lastnameController,
            keyboardType: TextInputType.text,
            onChanged: employedBloc.onChangeLastName,
            textInputAction: TextInputAction.next,
            validator: employedBloc.onValidationLastName,
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              labelText: "Apellidos",
              hintText: "Ingresa tus apellidos",
              labelStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              hintStyle: Theme.of(context).textTheme.bodyText2,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              errorStyle: const TextStyle(height: 0),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(25.0)),
          TextFormField(
            controller: employedBloc.ageController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: employedBloc.onChangeAge,
            validator: employedBloc.onValidationAge,
            style: Theme.of(context).textTheme.bodyText2,
            maxLength: 2,
            decoration: InputDecoration(
              labelText: "Edad",
              hintText: "Ingresa la edad",
              labelStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              hintStyle: Theme.of(context).textTheme.bodyText2,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              errorStyle: const TextStyle(height: 0.0),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(25.0)),
          TextFormField(
            controller: employedBloc.birthDayController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: employedBloc.onChangeBirthDay,
            validator: employedBloc.onValidationBirthDay,
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              labelText: "Fecha de nacimiento",
              hintText: "Ingresa la fecha de nacimiento",
              labelStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              hintStyle: Theme.of(context).textTheme.bodyText2,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              errorStyle: const TextStyle(height: 0.0),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () async {
              final formattedDate = await employedBloc.handleGetDateSelection(
                  context, DateTime.now());
              employedBloc.birthDayController.text = formattedDate;
              //   employedBloc.notifyListeners();
            },
          ),
          SizedBox(height: getProportionateScreenHeight(25.0)),
          TextFormField(
            controller: employedBloc.admissionDateController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: employedBloc.onChangeAdmissionDate,
            validator: employedBloc.onValidationAdmissionDate,
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              labelText: "Fecha de admision",
              hintText: "Ingresa la fecha de admision",
              labelStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              hintStyle: Theme.of(context).textTheme.bodyText2,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              errorStyle: const TextStyle(height: 0.0),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () async {
              final formattedDate = await employedBloc.handleGetDateSelection(
                  context, DateTime.now());
              employedBloc.admissionDateController.text = formattedDate;
              //   employedBloc.notifyListeners();
            },
          ),
          SizedBox(height: getProportionateScreenHeight(25.0)),
          TextFormField(
            controller: employedBloc.contractEndDateController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onChanged: employedBloc.onChangeContractEnd,
            validator: employedBloc.onValidationContractEnd,
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              labelText: "Fecha de termino de contrato",
              hintText: "Ingresa la fecha de termino de contrato",
              labelStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              hintStyle: Theme.of(context).textTheme.bodyText2,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              errorStyle: const TextStyle(height: 0.0),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () async {
              final formattedDate = await employedBloc.handleGetDateSelection(
                  context, DateTime.now());
              employedBloc.contractEndDateController.text = formattedDate;
              //   employedBloc.notifyListeners();
            },
          ),
          SizedBox(height: getProportionateScreenHeight(25.0)),
          ValueListenableBuilder(
            valueListenable: employedBloc.errors,
            builder: (context, List<String> value, child) {
              return FormError(errors: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(25.0)),
          DefaultButton(
            text: "Continuar",
            press: () {
              employedBloc.handleSaveEmployee(context);
            },
          ),
          const SizedBox(height: 20.0)
        ],
      ),
    );
  }
}
