import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:ccv_manager/events_widget/common/employee_checkbox_list.dart';
import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import '../common/form_fields/date_time_field.dart';
import '../models/cultural_events/form_task.dart';
import '../models/employee.dart';
import 'common/row_column_mobile_conditional_builder.dart'; // Other imports

// A separate stateful widget for each task item
class TaskItem extends StatefulWidget {
  final FormTask task;
  final int index;
  final Function(FormTask) onTaskUpdate;
  final List<Employee> availableEmployees;

  const TaskItem({
    Key? key,
    required this.task,
    required this.index,
    required this.onTaskUpdate,
    required this.availableEmployees,
  }) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  List<FormTask> formTasks = [];
  bool isMobileLayout = false;
  late Future<List<Map<String, dynamic>>> formTasksFuture; //
  final String _isComplete = "Concluída";
  final String _isInProgress = "A ser tratada";
  late FormTask task;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    task = widget.task;
  }

  void _toggleRequired(bool? newValue) {
    setState(() {
      task = task.copyWith(isNeeded: newValue);
    });
    widget.onTaskUpdate(task);
  }

  void _toggleCompletion(String progress, bool? newValue) {
    setState(() {
      if (progress == "Concluída" && newValue == true) {
        task = task.copyWith(progress: FormTaskProgress.completed);
      } else if (progress == "A ser tratada" && newValue == true) {
        task = task.copyWith(progress: FormTaskProgress.inProgress);
      }
    });
    widget.onTaskUpdate(task);
  }

  List<StepperData> getStepperData(FormTask task) {
    return [
      [
        "Tarefa Selecionada",
        task.isNeeded &&
            task.progress != FormTaskProgress.inProgress &&
            task.progress != FormTaskProgress.completed,
        DateTimeUtils.toDateString(task.endDate ?? DateTime.now())
      ],
      [
        "A ser tratada",
        task.progress == FormTaskProgress.inProgress,
        '',
      ],
      [
        "Concluída",
        task.progress == FormTaskProgress.completed,
        DateTimeUtils.toDateString(task.endDate ?? DateTime.now())
      ],
    ]
        .map((e) => StepperData(
              title: StepperText(
                e[0].toString(),
                textStyle: TextStyle(
                  color: e[1] as bool ? Colors.black54 : Colors.grey,
                ),
              ),
              subtitle: StepperText(
                e[2] as String,
              ),
              iconWidget: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: e[1] as bool ? Colors.teal : Colors.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.task.titleTranslation,
                style: TextStyle(
                  fontSize: 18,
                  color: widget.task.isNeeded ? Colors.teal : Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            widget.task.isNeeded
                ? Expanded(
                    child: AnotherStepper(
                      stepperList: getStepperData(widget.task),
                      stepperDirection: Axis.horizontal,
                      iconWidth:
                          40, // Height that will be applied to all the stepper icons
                      iconHeight:
                          40, // Width that will be applied to all the stepper icons
                    ),
                  )
                : Container()
          ],
        ),
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: const Text("Tarefa necessária:",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      )),
                  value: widget.task.isNeeded,
                  onChanged: (bool? value) {
                    _toggleRequired(value);
                  },
                ),
                widget.task.isNeeded
                    ? Column(children: [
                        const SizedBox(height: 20),
                        ConditionalParentWidget(
                          condition: isMobileLayout,
                          children: [
                            DateTimePicker(
                              header: 'Início:',
                              needsHour: true,
                              initialDateTime: DateTime.now(),
                              onDateTimeChanged: (newDateTime) {
                                setState(() {
                                  final updatedTask = widget.task
                                      .copyWith(startDate: newDateTime);

                                  // Notify the parent widget that the formTasks list has changed.
                                  // if (widget.onFormTasksChanged != null) {
                                  //   widget.onFormTasksChanged!(formTasks);
                                  // }
                                });
                              },
                            ),
                            DateTimePicker(
                              header: 'Fim:',
                              needsHour: true,
                              initialDateTime: DateTime.now()
                                  .add(const Duration(minutes: 60)),
                              onDateTimeChanged: (newDateTime) {
                                setState(() {
                                  final updatedTask = widget.task
                                      .copyWith(endDate: newDateTime);

                                  // if (widget.onFormTasksChanged != null) {
                                  //   widget.onFormTasksChanged!(formTasks);
                                  // }
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            EmployeeCheckboxList(
                              needsTimeRegister: false,
                              assignedEmployee: widget.task.assignedEmployee,
                              allEmployeesList: widget.availableEmployees,
                              allowsOnlyOneEmployee: true,
                              onChanged: (List<Employee> checkedEmployees) {
                                setState(() {
                                  final updatedTask = widget.task.copyWith(
                                      assignedEmployee: checkedEmployees.first);

                                  // Notify the parent widget that the formTasks list has changed.
                                  // if (widget.onFormTasksChanged != null) {
                                  //   widget.onFormTasksChanged!(formTasks);
                                  // }
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            const Divider(),
                            CheckboxListTile(
                              title: const Text("A ser tratada:",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                  )),
                              value: widget.task.progress ==
                                  FormTaskProgress.inProgress,
                              onChanged: (bool? value) {
                                _toggleCompletion(_isInProgress, value);
                              },
                            ),
                            CheckboxListTile(
                              title: const Text("Concluída:",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                  )),
                              value: widget.task.progress ==
                                  FormTaskProgress.completed,
                              onChanged: (bool? value) {
                                _toggleCompletion(_isComplete, value);
                              },
                            )
                          ],
                        ),
                      ])
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
