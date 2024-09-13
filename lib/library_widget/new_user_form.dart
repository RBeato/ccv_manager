import 'package:ccv_manager/library_widget/providers/library_user_provider.dart';
import 'package:ccv_manager/models/library_models/library_user.dart';
import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/appbar_editing_save_button.dart';
import '../common/form_fields/basic_text_form.dart';
import '../common/form_fields/date_time_field.dart';

class NewLibraryUserFormPage extends ConsumerStatefulWidget {
  const NewLibraryUserFormPage({Key? key}) : super(key: key);

  @override
  EventEditingPageState createState() => EventEditingPageState();
}

class EventEditingPageState extends ConsumerState<NewLibraryUserFormPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime currentDate;
  String? name;
  String? cc;
  DateTime? date;
  DateTime? birthDate;
  String? address;
  String? phoneNumber;
  String? mobileNumber;
  String? email;
  DateTime? registrationDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    const double sizedBoxHeight = 20;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar novo utilizador da biblioteca"),
        leading: const CloseButton(),
        backgroundColor: Colors.teal,
        actions: buildEditingActions(saveForm),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: sizedBoxHeight),
                    BasicTextForm(
                      title: "Nome",
                      isRequired: true,
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    const SizedBox(height: sizedBoxHeight),
                    Row(
                      children: [
                        Expanded(
                            child: BasicTextForm(
                          title: "B.I. ou C.C.",
                          isRequired: true,
                          onChanged: (value) {
                            cc = value;
                          },
                        )),
                        const SizedBox(width: sizedBoxHeight),
                        Expanded(
                          child: DateTimePicker(
                            header: 'Data de nascimento',
                            needsHour: false,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (newDateTime) {
                              final formattedDate =
                                  DateTimeUtils.toDateString(newDateTime);
                              final formattedTime =
                                  DateTimeUtils.toTimeString(newDateTime);
                              print('Selected date: $formattedDate');
                              print('Selected time: $formattedTime');
                              birthDate = newDateTime;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: sizedBoxHeight),
                    BasicTextForm(
                      title: "Morada",
                      maxLines: 2,
                      isRequired: true,
                      onChanged: (value) {
                        address = value;
                      },
                    ),
                    const SizedBox(height: sizedBoxHeight),
                    Row(
                      children: [
                        Expanded(
                            child: BasicTextForm(
                          title: "Telefone",
                          isPhone: true,
                          isRequired: true,
                          onChanged: (value) {
                            phoneNumber = value;
                          },
                        )),
                        const SizedBox(width: sizedBoxHeight),
                        Expanded(
                            child: BasicTextForm(
                          title: "Telemóvel",
                          isPhone: true,
                          isRequired: true,
                          onChanged: (value) {
                            mobileNumber = value;
                          },
                        )),
                      ],
                    ),
                    const SizedBox(height: sizedBoxHeight),
                    BasicTextForm(
                      title: "Email",
                      isEmail: true,
                      isRequired: true,
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    const SizedBox(height: sizedBoxHeight * 2),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    final LibraryUser newUser = LibraryUser(
      name: name!,
      cc: cc!,
      birthday: birthDate ?? DateTime.now(),
      address: address!,
      phone: phoneNumber!,
      mobile: mobileNumber!,
      email: email!,
      registrationDate: DateTime.now(),
    );

    await ref
        .read(libraryUserProvider.notifier)
        .add(newUser)
        .then((_) => Navigator.of(context).pop());
  }
}
