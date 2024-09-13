import 'package:ccv_manager/events_widget/provider/mini_event_provider.dart';
import 'package:ccv_manager/home_page/provider/user_provider.dart';
import 'package:ccv_manager/models/employee.dart';
import 'package:ccv_manager/models/personal_work_register/personal_work_register.dart';
import 'package:ccv_manager/models/todos/todo.dart';
import 'package:ccv_manager/shift_off_day_widget/shift_offday_editing_page/form_switch.dart';
import 'package:ccv_manager/shift_off_day_widget/types/custom_event_input.dart';
import 'package:ccv_manager/todo_widget/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/appbar_editing_save_button.dart';
import '../common/is_withing_working_hours.dart';
import '../constants/constants.dart';
import '../events_widget/common/employee_checkbox_list.dart';
import '../common/form_fields/basic_text_form.dart';
import '../home_page/home/home_page.dart';
import '../models/personal_work_register/mini_event.dart';
import '../shift_off_day_widget/provider/shift_provider.dart';

class TodoForm extends ConsumerStatefulWidget {
  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends ConsumerState<TodoForm> {
  final _formKey = GlobalKey<FormState>();

  String? title;
  DateTime? fromDate;
  DateTime? toDate;
  String? observations;
  List<Employee>? assignedEmployees;
  String? reqEntity;
  String? assignedEmployee;

  @override
  Widget build(BuildContext context) {
    double sizedBoxHeight = 24;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Criar Tarefa"),
          leading: const CloseButton(),
          backgroundColor: Colors.teal,
          actions: buildEditingActions(saveForm),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            BasicTextForm(
                                title: "Título",
                                isPhone: true,
                                isRequired: true,
                                onChanged: (value) {
                                  title = value;
                                }),
                            SizedBox(height: sizedBoxHeight),
                            SizedBox(height: sizedBoxHeight),
                            const CustomEventInputForm(
                              type: Constants.todo,
                              category: SelectedCategory.task,
                            ),
                          ],
                        )),
                  ),
                  Card(
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: BasicTextForm(
                                title: "Requerente",
                                isPhone: true,
                                isRequired: true,
                                onChanged: (value) {
                                  reqEntity = value;
                                },
                              )),
                              SizedBox(width: sizedBoxHeight),
                            ],
                          ),
                          SizedBox(height: sizedBoxHeight),
                          SizedBox(height: sizedBoxHeight),
                          EmployeeCheckboxList(
                              onChanged: (List<Employee> checkedEmployees) {
                            assignedEmployees = checkedEmployees;
                            print(checkedEmployees);
                          }),
                          SizedBox(height: sizedBoxHeight),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BasicTextForm(
                        title: 'Observações',
                        isRequired: false,
                        onChanged: (value) {
                          observations = value;
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    if (_formKey.currentState!.validate()) {
      var mini = ref.read(miniEventsProvider);

      MiniEvent miniEvent;

      if (mini != null && mini.isNotEmpty) {
        miniEvent = ref.read(miniEventsProvider)!.first;
      } else {
        miniEvent = MiniEvent(
            category: SelectedCategory.task,
            from: DateTime.now(),
            to: DateTime.now(),
            type: 'Tarefa');
      }

      if (assignedEmployees == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Selecione pelo menos um funcionário"),
          ),
        );
        return;
      } else {
        for (var employee in assignedEmployees!) {
          TodoEvent event = TodoEvent(
            title: title!,
            fromDate: miniEvent.from!,
            toDate: miniEvent.to!,
            eventCreationDate: DateTime.now(),
            eventCreator: ref.read(userProvider).value?.name ?? "Não definido",
            eventType: EventType.task,
            observations: observations,
            assignedEmployee: employee,
            employees: assignedEmployees,
            requester: reqEntity,
          );
          ref.read(todoProvider.notifier).add(event);

          if (!isWithinWorkingHours(miniEvent.from!, miniEvent.to!)) {
            ref.read(shiftProvider.notifier).add(PersonalWorkRegisterEvent(
                title: event.title!,
                // assignedEmployee: assignedEmployee,
                fromDate: event.fromDate,
                toDate: event.toDate,
                type: Constants.hours,
                eventCreationDate: DateTime.now(),
                eventCreator:
                    ref.read(userProvider).value?.name ?? "Não definido",
                eventType: EventType.shift,
                observations: observations,
                employees: assignedEmployees));
          }
        }
      }
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
}
