import 'package:centralcareweb/medico/components/next_patient/build_next_patients.dart';
import 'package:centralcareweb/medico/components/on_appointment/build_on_appointment.dart';
import 'package:centralcareweb/recepcionista/components/new_date_doctor/details_date_doctor/details_date_doctor.dart';
import 'package:centralcareweb/store/medico_page/next_patients/patient_on_appointment/patient_on_appointment_store.dart';
import 'package:centralcareweb/store/show_pages/show_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../components/responsive_builder.dart';
import '../store/medico_page/next_patients/next_patients_store.dart';
import 'components/home/build_home.dart';
import 'components/side_bar/build_side_bar_doctor.dart';

class MedicoPage extends StatelessWidget {
  final PatientOnAppointmentStore patientOnAppointmentStore =  GetIt.I<PatientOnAppointmentStore>();
  final ShowStore showHomeStore =  GetIt.I<ShowStore>();
  final NextPatientsStore nextPatientsStore =  GetIt.I<NextPatientsStore>();

  MedicoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    nextPatientsStore.fetchPatientsToday();
    nextPatientsStore.fetchAttendanceStart();
    return Observer(
      builder: (BuildContext context) {
        showHomeStore.showInHomeDoctor;
        return GestureDetector(
          onTap: (){
            if (!kIsWeb) {
              patientOnAppointmentStore.htmlEditorController.clearFocus();
            }
          },
          child: Scaffold(
              drawer: ResponsiveBuilder.isDesktop(context)
                  ? null
                  : Drawer(
                child: SafeArea(
                  child: SingleChildScrollView(
                    controller: ScrollController(initialScrollOffset: 0),
                    child: const BuildSideBarDoctor(),
                  ),
                ),
              ),
              body: SafeArea(
                  child: ResponsiveBuilder(mobileBuilder: (context, constraints) {
                    return SingleChildScrollView(
                      controller: ScrollController(initialScrollOffset: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          showHomeStore.showInHomeDoctor == 1 ? BuildHome() :
                          showHomeStore.showInHomeDoctor == 2 ? BuildOnAppointmentCard() :
                          showHomeStore.showInHomeDoctor == 3 ? DetailsDateDoctor(recepcionista: false,): Center(),
                          BuildNextPatients()
                        ],
                      ),
                    );
                  }, tabletBuilder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: constraints.maxWidth > 800 ? 8 : 7,
                          child: SingleChildScrollView(
                            controller: ScrollController(initialScrollOffset: 0),
                            child:
                            showHomeStore.showInHomeDoctor == 1 ? BuildHome() :
                            showHomeStore.showInHomeDoctor == 2 ? BuildOnAppointmentCard() :
                            showHomeStore.showInHomeDoctor == 3 ? DetailsDateDoctor(recepcionista: false,): Center(),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: const VerticalDivider(),
                        ),
                        Flexible(
                          flex: 4,
                          child: SingleChildScrollView(
                            controller: ScrollController(initialScrollOffset: 0),
                            child: BuildNextPatients(),
                          ),
                        ),
                      ],
                    );
                  }, desktopBuilder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            flex: constraints.maxWidth > 1350 ? 3 : 4,
                            child: BuildSideBarDoctor()),
                        Flexible(
                          flex: constraints.maxWidth > 1350 ? 10 : 9,
                          child:
                          showHomeStore.showInHomeDoctor == 1 ? BuildHome() :
                          showHomeStore.showInHomeDoctor == 2 ? BuildOnAppointmentCard() :
                          showHomeStore.showInHomeDoctor == 3 ? DetailsDateDoctor(recepcionista: false,): Center(),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: const VerticalDivider(),
                        ),
                        Flexible(flex: 4, child: BuildNextPatients()),
                      ],
                    );
                  }))),
        );
      },
    );
  }
}