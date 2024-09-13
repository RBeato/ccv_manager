import 'package:ccv_manager/models/calendar_event/calendar_event.dart';
import 'package:ccv_manager/visitor_register/provider/visitorProvider.dart';
import 'package:ccv_manager/visitor_register/provider/visitor_counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/appbar_editing_save_button.dart';
import '../common/form_fields/basic_text_form.dart';
import '../common/form_fields/date_time_field.dart';
import '../home_page/home/home_page.dart';
import '../models/visitors/visitor_register_event.dart';

class VisitorRegisterForm extends ConsumerStatefulWidget {
  @override
  _VisitorRegisterFormState createState() => _VisitorRegisterFormState();
}

class _VisitorRegisterFormState extends ConsumerState<VisitorRegisterForm> {
  // final int _visitorCount = 0;
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  String? observations;

  @override
  Widget build(BuildContext context) {
    ref.watch(visitorInputValueProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registar Visitantes"),
          leading: const CloseButton(),
          backgroundColor: Colors.teal,
          actions: buildEditingActions(saveForm),
        ),
        body: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: [
                    const Center(
                      child: Text("Data: ",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 18)),
                    ),
                    Expanded(
                      child: DateTimePicker(
                        header: "",
                        needsHour: true,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (newDateTime) {
                          date = newDateTime;
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Visitantes: ",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 18)),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          // initialValue:
                          //     ref.read(visitorCountProvider).toString(),
                          onChanged: (value) {
                            ref
                                .read(visitorInputValueProvider.notifier)
                                .update((state) => int.tryParse(value) ?? 0);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  BasicTextForm(
                    title: "Observações",
                    initialValue: observations,
                    isRequired: false,
                    onChanged: (value) {
                      observations = value;
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    try {
      ref.read(visitorProvider.notifier).add(
            VisitorRegisterEvent(
                fromDate: date,
                toDate: date.add(const Duration(minutes: 30)),
                visitorCounter: ref.read(visitorInputValueProvider)),
          );
    } catch (e) {
      debugPrint("Something went wrong: $e");
    }

    ref.read(visitorInputValueProvider.notifier).update((state) => 0);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );

    //  await firestoreService
    //         .add(event.toJson(), FirestoreCollection.events)
    //         .then((_) => Navigator.of(context).pop(event));
  }
}
