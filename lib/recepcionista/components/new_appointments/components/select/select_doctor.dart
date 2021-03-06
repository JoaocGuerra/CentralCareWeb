import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:group_button/group_button.dart';

import '../../../../../store/recepcionista_page/new_appointment/doctors_store.dart';
import '../../../../../store/recepcionista_page/new_appointment/marcar_consulta_store.dart';

class SelectDoctor extends StatelessWidget {
  final MarcarConsultaStore marcarConsultaStore = GetIt.I<MarcarConsultaStore>();
  final DoctorsStoreNewAppointment doctorsStore =  GetIt.I<DoctorsStoreNewAppointment>();

  SelectDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    doctorsStore.fetchDoctors();
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: marcarConsultaStore.maxWidth),
      child: Observer(
          builder:(_){
            return Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Selecione o médico",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 75,
                  child: doctorsStore.loading ?
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                    :
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GroupButton(
                        buttons: doctorsStore.doctorNames,
                        maxSelected: 1,
                        onSelected: (i, selected){
                          marcarConsultaStore.setSelectedDoctor(doctorsStore.doctorID[i]);
                          marcarConsultaStore.setNameDoctor(doctorsStore.doctorNames[i]);
                          marcarConsultaStore.clearFieldsDoctor();
                        },
                        options: GroupButtonOptions(
                          textAlign: TextAlign.center,
                          elevation: 2,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(height: 5),
              ],
            );
          }
      ),
    );
  }
}