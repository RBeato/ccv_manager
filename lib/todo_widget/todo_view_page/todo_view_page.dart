import 'package:ccv_manager/todo_widget/provider/todo_provider.dart';
import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/check_is_mobile.dart';
import '../../common/custom_text_for_card.dart';
import '../../common/delete_button.dart';
import '../../events_widget/common/row_column_mobile_conditional_builder.dart';
import '../../home_page/provider/user_provider.dart';
import '../../models/calendar_event/calendar_event.dart';
import '../../services/firebase_storing.dart';

class TodoCardViewPage extends ConsumerStatefulWidget {
  const TodoCardViewPage({required this.todo, this.constraints, super.key});
  final CalendarEvent todo;
  final BoxConstraints? constraints;

  @override
  ConsumerState<TodoCardViewPage> createState() => _TodoCardViewPageState();
}

class _TodoCardViewPageState extends ConsumerState<TodoCardViewPage> {
  late CalendarEvent todo;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    todo = widget.todo;
    _isChecked = todo.isCompleted ?? false;
  }

  final TextStyle _dataStyle = const TextStyle(
    color: Colors.black87,
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefa"),
        backgroundColor: Colors.teal,
        leading: const CloseButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextForCard("Título: ", todo.title!),
                          ConditionalParentWidget(
                            condition: isMobile(widget.constraints),
                            children: [
                              CustomTextForCard(
                                "De: ",
                                DateTimeUtils.toDateTimeString(todo.fromDate),
                              ),
                              CustomTextForCard("Até: ",
                                  DateTimeUtils.toDateTimeString(todo.toDate)),
                            ],
                          ),
                          ConditionalParentWidget(
                              condition: isMobile(widget.constraints),
                              children: const [
                                // CustomTextForCard(
                                //     "Requerente: ", todo.requester!),
                                // CustomTextForCard("Funcionário responsável: ",
                                //     todo.assignedEmployee!.name ?? ""),
                              ]),
                          ConditionalParentWidget(
                              condition: isMobile(widget.constraints),
                              children: [
                                CustomTextForCard("Criador da tarefa: ",
                                    todo.eventCreator ?? "Administrador"),
                                CustomTextForCard(
                                    "Data de criação da tarefa: ",
                                    DateTimeUtils.toDateTimeString(
                                        todo.eventCreationDate ??
                                            DateTime.now())),
                              ]),
                          // CustomTextForCard(
                          //     "Local: ", todo.room ?? "Não registado"),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: CustomTextForCard(
                                  "Observações: ", todo.observations ?? "")),
                        ],
                      ),
                    )),
                Card(
                    elevation: 5,
                    child: CheckboxListTile(
                      title: Text("Concluída:", style: _dataStyle),
                      value: _isChecked,
                      onChanged: (bool? value) {
                        _toggleCompletion(value, todo);
                      },
                    )),
              ],
            ),
            CardViewDeleteButton(
              buttonText: "Eliminar",
              dialogTitleText: "Eliminar evento",
              contentText: "Tem a certeza que pretende eliminar este evento?",
              actionButtonText: "ELIMINAR",
              onPressed: () async {
                //!TODO: Create notification for all users
                FirestoreService firestoreService = FirestoreService();
                await firestoreService
                    .delete(todo.id!, FirestoreCollection.shifts)
                    .then((_) => Navigator.of(context).pop());
              },
            ),
          ],
        ),
      ),
    );
  }

  _toggleCompletion(value, todo) async {
    await ref.read(todoProvider.notifier).edit(todo.copyWith(
        isCompleted: _isChecked,
        lastEditedBy: ref.read(userProvider).value?.name,
        lastEditedOn: DateTime.now()));
    todo.deliveryDate = _isChecked ? todo.deliveryDate : null;

    setState(() {
      _isChecked = value!;
    });
  }
}
