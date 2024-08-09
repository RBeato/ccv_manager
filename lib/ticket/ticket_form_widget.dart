// import 'package:flutter/material.dart';

// import '../common/form_fields/basic_text_form.dart';

// class TicketFormWidget extends StatefulWidget {
//   const TicketFormWidget({super.key});

//   // @override
//   State<TicketFormWidget> createState() => _TicketFormWidgetState();
// }

// class _TicketFormWidgetState extends State<TicketFormWidget> {
//   final _formKey = GlobalKey<FormState>();

//   static const Map<int, String> _options = {0: "Reserva", 1: "Compra"};
//   int _selectedValue = 0;
//   String? name;
//   String? contact;
//   String? option;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Registar lugar no auditório"),
//           backgroundColor: Colors.teal,
//           leading: const CloseButton(),
//           actions: buildEditingActions(saveForm),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                               flex: 4,
//                               child: BasicTextForm(
//                                 title: "Nome:",
//                                 isPhone: true,
//                                 isRequired: true,
//                                 onChanged: (value) {
//                                   name = value;
//                                 },
//                               )),
//                           const SizedBox(width: 16),
//                           Expanded(
//                               child: BasicTextForm(
//                             title: "Contacto: ",
//                             isPhone: true,
//                             isRequired: true,
//                             onChanged: (value) {
//                               contact = value;
//                             },
//                           )),
//                           ..._options.entries
//                               .map((e) => Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20.0),
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           e.value,
//                                           style: const TextStyle(
//                                               color: Colors.black54,
//                                               fontSize: 18),
//                                         ),
//                                         Radio(
//                                           value: e.key,
//                                           groupValue: _selectedValue,
//                                           onChanged: (int? value) {
//                                             option = _options[value];
//                                             setState(() {
//                                               _selectedValue = value!;
//                                             });
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ))
//                               .toList(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const TicketWidget(),
//             ],
//           ),
//         ));
//   }

//   Future saveForm() async {
//     final isValid = _formKey.currentState!.validate();
//     if (!isValid) return;
//     if (_formKey.currentState!.validate()) {
//       // ref.read(bookProvider.notifier).add(BookRequest(
//       //     title: 'title',
//       //     edition: 'edition',
//       //     author: 'author',
//       //     userId: '123',
//       //     userName: 'userName',
//       //     deliveryDateLimit: DateTime.now(),
//       //     requestDate: DateTime.now(),
//       //     renewed: false,
//       //     observations: 'observations',
//       //     deliveryDate: null,
//       //     status: RequisitionStatus.toBeDelivered));
//     }
//   }
// }
