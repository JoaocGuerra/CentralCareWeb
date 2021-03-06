import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../components/custom_textformfield.dart';
import '../../../../../../store/master_page/tabs/register_tab/register_tab_store.dart';
import '../../../../../../store/recepcionista_page/register_patient/register_patient_store.dart';

class FormFieldPasswordRegisterPatient extends StatelessWidget {
  final RegisterPatientStore registerPatientStore =  GetIt.I<RegisterPatientStore>();

  FormFieldPasswordRegisterPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: registerPatientStore.maxWidthBoxConstrains),
      child: CustomTextFormField(
        list: const [],
        textEditingController: registerPatientStore.passwordController,
        isPasswordType: false,
        icon: Icons.lock,
        text: 'Senha',
        textInputType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "Senha Inválida";
          }
          return null;
        },
      ),
    );
  }
}