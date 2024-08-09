import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/appbar_editing_save_button.dart';
import '../common/form_fields/basic_text_form.dart';
import '../common/form_fields/date_time_field.dart';

class SuggestionFormPage extends ConsumerStatefulWidget {
  const SuggestionFormPage({Key? key}) : super(key: key);

  @override
  EventEditingPageState createState() => EventEditingPageState();
}

class EventEditingPageState extends ConsumerState<SuggestionFormPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime currentDate;
  String? author;
  String? description;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    const double sizedBoxHeight = 30;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sugestão"),
        leading: const CloseButton(),
        actions: buildEditingActions(saveForm),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        BasicTextForm(
                          title: "Author",
                          isRequired: true,
                          onChanged: (value) {
                            author = value;
                          },
                        ),
                        const SizedBox(height: sizedBoxHeight),
                        Expanded(
                          child: DateTimePicker(
                            header: 'Data',
                            needsHour: false,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (newDateTime) {
                              final formattedDate =
                                  DateTimeUtils.toDateString(newDateTime);
                              final formattedTime =
                                  DateTimeUtils.toTimeString(newDateTime);
                              print('Selected date: $formattedDate');
                              print('Selected time: $formattedTime');
                              date = newDateTime;
                            },
                          ),
                        ),
                        BasicTextForm(
                          title: "Descrição",
                          isRequired: true,
                          maxLines: 3,
                          onChanged: (value) {
                            description = value;
                          },
                        ),
                        const SizedBox(width: sizedBoxHeight),
                        // const Text('Link to library rules'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    // Suggestion suggestion =
    //     Suggestion(author: author!, date: date!, description: description!);
  }
}
