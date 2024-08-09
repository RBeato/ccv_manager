import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/appbar_editing_save_button.dart';
import '../common/check_is_mobile.dart';
import '../events_widget/common/row_column_mobile_conditional_builder.dart';
import '../home_page/floating_action_button/floating_button.dart';
import '../models/library_models/book.dart';
import '../models/library_models/book_request.dart';
import 'book_requisition_form.dart';

import 'providers/book_provider.dart';

class BookRequestCardViewPage extends ConsumerStatefulWidget {
  const BookRequestCardViewPage(this.bookRequest, {super.key});

  final BookRequest bookRequest;

  @override
  ConsumerState<BookRequestCardViewPage> createState() =>
      _BookRequestCardViewPageState();
}

class _BookRequestCardViewPageState
    extends ConsumerState<BookRequestCardViewPage> {
  final _formKey = GlobalKey<FormState>();
  final int _selectedNumber = 1;

  bool _isDeliveryChecked = false;
  bool _isRenewChecked = false;

  final TextStyle _style = const TextStyle(
    color: Colors.black54,
    fontSize: 18,
  );

  final TextStyle _dataStyle = const TextStyle(
    color: Colors.black87,
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    final bookRequest = widget.bookRequest;
    ref.watch(bookProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ficha de requisição de livro"),
          backgroundColor: Colors.teal,
          leading: const CloseButton(),
          actions: buildEditingActions(() => saveForm(bookRequest)),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
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
                            ConditionalParentWidget(
                              condition: isMobile(constraints),
                              children: [
                                Row(children: [
                                  Text("Nome do Utilizador: ", style: _style),
                                  Expanded(
                                      child: Text(bookRequest.userName,
                                          overflow: TextOverflow.ellipsis,
                                          style: _dataStyle)),
                                ]),
                                Row(
                                  children: [
                                    Text("Nº do Utilizador: ", style: _style),
                                    Expanded(
                                        child: Text(bookRequest.userId,
                                            overflow: TextOverflow.ellipsis,
                                            style: _dataStyle)),
                                  ],
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  Text('Número de livros: ', style: _style),
                                  const SizedBox(width: 16),
                                  Text(bookRequest.books.length.toString(),
                                      style: _dataStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: getBookDataFormulary(
                            bookRequest.books, constraints),
                      ),
                    )),
                    Card(
                      // elevation: 3,
                      shadowColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConditionalParentWidget(
                              condition: isMobile(constraints),
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Data de requisição: ", style: _style),
                                    Expanded(
                                      child: Text(
                                          DateTimeUtils.toDateTimeString(
                                              bookRequest.requestDate),
                                          overflow: TextOverflow.ellipsis,
                                          style: _dataStyle),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Data de limite de entrega: ",
                                        style: _style),
                                    Expanded(
                                      child: Text(
                                          DateTimeUtils.toDateTimeString(
                                              bookRequest.deliveryDateLimit),
                                          overflow: TextOverflow.ellipsis,
                                          style: _dataStyle),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            ConditionalParentWidget(
                              condition: isMobile(constraints),
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Data de entrega: ", style: _style),
                                    Expanded(
                                      child: Text(
                                          bookRequest.deliveryDate == null
                                              ? ""
                                              : DateTimeUtils.toDateTimeString(
                                                  bookRequest.deliveryDate!),
                                          overflow: TextOverflow.ellipsis,
                                          style: _dataStyle),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Renovou requisição: ", style: _style),
                                    Text(
                                        bookRequest.renewed == true
                                            ? "Sim"
                                            : "Não",
                                        style: _dataStyle),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Observações: ', style: _style),
                                Expanded(
                                  child: Text(
                                    bookRequest.observations ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: _dataStyle,
                                    textAlign: TextAlign.justify,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          CheckboxListTile(
                            title: Text("Entregue:", style: _dataStyle),
                            value: _isDeliveryChecked,
                            onChanged: (bool? value) async {
                              if (_isRenewChecked) {
                                return;
                              }
                              setState(() {
                                _isDeliveryChecked = value!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title:
                                Text("Renovar requisição:", style: _dataStyle),
                            value: _isRenewChecked,
                            onChanged: (bool? value) async {
                              if (_isDeliveryChecked) {
                                return;
                              }
                              setState(() {
                                _isRenewChecked = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
        floatingActionButton: CustomFloatingButton(
          title: "Editar",
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BookRequestForm(
                    bookRequest: bookRequest,
                  ))),
        ));
  }

  List<Widget> getBookDataFormulary(List<Book> books, [constraints]) {
    List<Widget> temp = [];
    for (var i = 0; i < books.length; i++) {
      temp.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ConditionalParentWidget(
            condition: isMobile(constraints),
            children: [
              Row(
                children: [
                  Text("Título: ", style: _style),
                  Text(books[i].title, style: _dataStyle),
                ],
              ),
              Row(
                children: [
                  Text("Edição: ", style: _style),
                  Text(books[i].edition, style: _dataStyle),
                ],
              ),
              Row(
                children: [
                  Text("Autor: ", style: _style),
                  Text(books[i].author, style: _dataStyle),
                ],
              ),
            ]),
      ));
    }
    return temp;
  }

  Future saveForm(BookRequest bookRequest) async {
    if (_formKey.currentState == null) {
      return;
    }
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    if (_formKey.currentState!.validate()) {
      await ref
          .read(bookProvider.notifier)
          .edit(bookRequest.copyWith(
            deliveryDate: getDeliveryDate(),
            renewed: _isRenewChecked,
            deliveryDateLimit: getDeliveryDateLimit(bookRequest),
            status: getStatus(bookRequest),
          ))
          .then((_) => Navigator.of(context).pop(true));
    }
  }

  getStatus(bookRequest) {
    return _isRenewChecked
        ? RequisitionStatus.toBeDelivered
        : _isDeliveryChecked
            ? RequisitionStatus.delivered
            : bookRequest.status;
  }

  getDeliveryDate() {
    return _isRenewChecked
        ? null
        : _isDeliveryChecked
            ? DateTime.now()
            : null;
  }

  getDeliveryDateLimit(bookRequest) => _isRenewChecked
      ? DateTime.now().add(const Duration(days: 15))
      : _isDeliveryChecked
          ? DateTime.now()
          : bookRequest.deliveryDateLimit;
}
