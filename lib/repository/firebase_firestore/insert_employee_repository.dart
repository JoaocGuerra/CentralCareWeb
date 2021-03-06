import 'dart:math';

import 'package:centralcareweb/utils/utils_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import '../../store/auth/auth_store.dart';
import '../../store/master_page/tabs/register_tab/register_tab_store.dart';

class InsertEmployeeRepository{

  final _db = FirebaseFirestore.instance;
  final RegisterTabStore registerTabStore =  GetIt.I<RegisterTabStore>();
  final AuthStore authStore =  GetIt.I<AuthStore>();

  Future<void> insertEmployee()async {

    FirebaseApp app = await Firebase.initializeApp(
        name: registerTabStore.cpfController.text+registerTabStore.birthdayController.text, options: Firebase.app().options);
    UserCredential result = await FirebaseAuth.instanceFor(app: app)
        .createUserWithEmailAndPassword(
        email: registerTabStore.emailController.text.trim(),
        password: registerTabStore.passwordController.text.trim());

    app.delete();

    Map<String, dynamic> mapInsert = new Map<String, dynamic>();
    String genero = registerTabStore.gender.toLowerCase();

    mapInsert["nome"] = registerTabStore.nameController.text;
    mapInsert["sobrenome"] = registerTabStore.lastNameController.text;
    mapInsert["email"] = registerTabStore.emailController.text;
    mapInsert["cpf"] = registerTabStore.cpfController.text;
    mapInsert["data_nascimento"] = registerTabStore.birthdayController.text;
    mapInsert["genero"] = genero;
    mapInsert["funcao"] = registerTabStore.function.toLowerCase();
    if(registerTabStore.function=="MEDICO") {
      String especialidade = UtilsString.capitalize(registerTabStore.specialtyController.text);
      mapInsert["especialidade"] = especialidade;
      if(genero == "masculino") {
        mapInsert["foto"] = "https://cdn.icon-icons.com/icons2/1999/PNG/512/avatar_man_people_person_profile_user_icon_123385.png";
      } else if (genero == "feminino") {
        mapInsert['foto'] = "https://cdn.icon-icons.com/icons2/2292/PNG/512/doctor_asian_female_people_avatar_icon_141428.png";
      }

      await _db.collection('especialidades').doc(especialidade).get().then((snapshot) {

        Map<String, dynamic> dataUpdate = Map<String, dynamic>();
        List<dynamic> listaFuncionarios = [];

        if(snapshot.exists){
          listaFuncionarios = snapshot.get("lista_funcionarios");
          listaFuncionarios.add(result.user?.uid ?? "");

          dataUpdate['lista_funcionarios'] = listaFuncionarios;

          _db.collection('especialidades').doc(especialidade).set(dataUpdate);
        }else{
          listaFuncionarios.add(result.user?.uid ?? "");

          dataUpdate['lista_funcionarios'] = listaFuncionarios;

          _db.collection('especialidades').doc(especialidade).set(dataUpdate);
        }

      });

    }

      await _db.collection('funcionarios').doc(result.user?.uid).set(mapInsert);
  }

}