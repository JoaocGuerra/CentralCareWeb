import 'package:centralcareweb/store/recepcionista_page/register_patient/register_patient_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../components/custom_textformfield.dart';
import '../../../../../../store/master_page/tabs/register_tab/register_tab_store.dart';

class FormFieldPasswordRegisterTab extends StatelessWidget {
  final RegisterTabStore registerTabStore =  GetIt.I<RegisterTabStore>();

  FormFieldPasswordRegisterTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: registerTabStore.maxWidthBoxConstrains),
      child: CustomTextFormField(
        list: const [],
        textEditingController: registerTabStore.passwordController,
        isPasswordType: false,
        icon: Icons.lock,
        text: 'Senha',
        textInputType: TextInputType.visiblePassword,
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
