import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/home_page/floating_action_button/floating_button.dart';
import 'package:ccv_manager/library_widget/new_user_form.dart';
import 'package:ccv_manager/library_widget/providers/book_provider.dart';
import 'package:ccv_manager/library_widget/providers/current_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/appbar_editing_save_button.dart';
import '../common/form_fields/basic_text_form.dart';
import '../common/form_fields/date_time_field.dart';
import '../common/form_fields/search_field.dart';
import '../models/library_models/book.dart';
import '../models/library_models/book_request.dart';

class BookRequestForm extends ConsumerStatefulWidget {
  const BookRequestForm({this.bookRequest, super.key});

  final BookRequest? bookRequest;

  @override
  _BookRequestFormState createState() => _BookRequestFormState();
}

class _BookRequestFormState extends ConsumerState<BookRequestForm> {
  final _formKey = GlobalKey<FormState>();
  late int _selectedNumber;
  final bool _isChecked = false;
  String? userName, userNumber, title, author, edition, observations;
  DateTime? requestDate, deliveryDate;
  List books = [];

  TextEditingController userNameController = TextEditingController();
  TextEditingController userNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedNumber =
        widget.bookRequest != null ? widget.bookRequest!.books.length : 1;

    if (widget.bookRequest == null) {
      books = List<Book>.generate(
        _selectedNumber,
        (_) => Book(author: "", title: "", edition: ""),
      );
    } else {
      books = widget.bookRequest!.books;
    }

    userNameController.text = widget.bookRequest?.userName ?? '';
    userNumberController.text = widget.bookRequest?.userId ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentLibraryUserProvider);
    final bookRequest = widget.bookRequest;

    // Update the controllers with the new values
    userNameController.text = currentUser?.name ?? '';
    userNumberController.text = currentUser?.id ?? '';

    return Scaffold(
        appBar: AppBar(
          title: const Text("Requisição de livros"),
          backgroundColor: Colors.teal,
          leading: const CloseButton(),
          actions: buildEditingActions(() => saveForm(books)),
        ),
        floatingActionButton: CustomFloatingButton(
          title: "Novo Utilizador",
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const NewLibraryUserFormPage())),
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
                                SearchInput(),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: BasicTextForm(
                                        title: "Nome do utilizador",
                                        controller: userNameController,
                                        isPhone: true,
                                        isRequired: true,
                                        onChanged: (value) {
                                          userName = value;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: BasicTextForm(
                                        title: "Nº de utilizador",
                                        controller: userNumberController,
                                        isPhone: true,
                                        isRequired: true,
                                        onChanged: (value) {
                                          userNumber = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      const Text('Número de livros: ',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18,
                                          )),
                                      const SizedBox(height: 16),
                                      DropdownButton<int>(
                                        value: _selectedNumber,
                                        items: [1, 2, 3]
                                            .map((number) => DropdownMenuItem(
                                                  value: number,
                                                  child: Text('$number'),
                                                ))
                                            .toList(),
                                        onChanged: (int? newValue) {
                                          _selectedNumber = newValue!;
                                          changeBooksList();
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ...getBookDataFormulary(bookRequest),
                        Card(
                          elevation: 3,
                          shadowColor: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: DateTimePicker(
                                      header: "Data de Requisição",
                                      needsHour: false,
                                      initialDateTime:
                                          bookRequest?.requestDate ??
                                              DateTime.now(),
                                      onDateTimeChanged: (newDateTime) {
                                        requestDate = newDateTime;
                                      },
                                    )),
                                    Expanded(
                                        child: DateTimePicker(
                                      header: "Data Limite de Entrega",
                                      needsHour: false,
                                      initialDateTime: bookRequest
                                              ?.deliveryDateLimit ??
                                          DateTime.now()
                                              .add(const Duration(days: 15)),
                                      onDateTimeChanged: (newDateTime) {
                                        deliveryDate = newDateTime;
                                      },
                                    )),
                                    // const SizedBox(width: 16),
                                    // Expanded(
                                    //   child: CheckboxListTile(
                                    //     title: const Text('Renovação da requisição'),
                                    //     value: bookRequest?.renewed ?? _isChecked,
                                    //     onChanged: (bool? value) {
                                    //       setState(() {
                                    //         _isChecked = value!;
                                    //       });
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                BasicTextForm(
                                  title: 'Observações',
                                  initialValue: bookRequest?.observations ?? '',
                                  isRequired: false,
                                  onChanged: (value) {
                                    observations = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ))));
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    userNameController.dispose();
    userNumberController.dispose();
    super.dispose();
  }

  changeBooksList() {
    // If the new value is greater, add more books to the list.
    if (_selectedNumber > books.length) {
      books.addAll(List<Book>.generate(
        _selectedNumber - books.length,
        (_) => Book(author: "", title: "", edition: ""),
      ));
    }
    // If the new value is smaller, remove the last books from the list.
    else if (_selectedNumber < books.length) {
      books = books.sublist(0, _selectedNumber);
    }
  }

  List<Widget> getBookDataFormulary(BookRequest? bookRequest) {
    List<Widget> temp = [];

    var length = bookRequest?.books.length ?? _selectedNumber;

    for (var i = 0; i < length; i++) {
      temp.add(Card(
        shadowColor: Colors.grey,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            BasicTextForm(
              title: 'Título',
              initialValue: bookRequest?.books[i].title ?? "",
              isRequired: true,
              onChanged: (value) {
                setState(() {
                  title = value;
                  books[i].title = value;
                });
              },
            ),
            BasicTextForm(
              title: 'Edição',
              initialValue: bookRequest?.books[i].edition ?? "",
              isRequired: true,
              onChanged: (value) {
                setState(() {
                  edition = value;
                  books[i].edition = value;
                });
              },
            ),
            BasicTextForm(
                title: 'Autor',
                initialValue: bookRequest?.books[i].author ?? "",
                isRequired: true,
                onChanged: (value) {
                  setState(() {
                    author = value;
                    books[i].author = value;
                  });
                }),
          ]),
        ),
      ));
    }
    return temp;
  }

  Future saveForm(books) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    BookRequest? bookRequest = widget.bookRequest;
    var bks = books.cast<Book>();

    if (_formKey.currentState!.validate()) {
      await ref
          .read(bookProvider.notifier)
          .add(BookRequest(
              userId:
                  bookRequest?.userId ?? userNumberController.text ?? 'userId',
              userName: bookRequest?.userName ??
                  userNameController.text ??
                  'userName',
              eventType: EventType.bookRequest,
              books: bks,
              deliveryDateLimit: bookRequest?.deliveryDateLimit ??
                  deliveryDate ??
                  DateTime.now().add(const Duration(days: 15)),
              requestDate:
                  bookRequest?.requestDate ?? requestDate ?? DateTime.now(),
              renewed: bookRequest?.renewed ?? false,
              observations:
                  bookRequest?.observations ?? observations ?? 'observations',
              deliveryDate: deliveryDate,
              status: RequisitionStatus.toBeDelivered))
          .then((value) => Navigator.of(context).pop());
    }
  }
}
