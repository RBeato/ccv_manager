import 'package:ccv_manager/devil_costumes/costume_form/buy_costume.dart';
import 'package:ccv_manager/models/library_models/book_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/appbar_editing_save_button.dart';
import '../../common/check_is_mobile.dart';
import '../../common/form_fields/basic_text_form.dart';
import '../../constants/constants.dart';
import '../../events_widget/common/row_column_mobile_conditional_builder.dart';
import '../../models/devil_costumes/devil_costume.dart';
import '../../models/devil_costumes/devil_costume_request.dart';
import '../providers/costume_requisition_provider.dart';
import '../providers/devil_costume_provider.dart';
import 'costume_rental.dart';

class DevilCostumeRequestForm extends ConsumerStatefulWidget {
  @override
  _DevilCostumeRequestFormState createState() =>
      _DevilCostumeRequestFormState();
}

class _DevilCostumeRequestFormState
    extends ConsumerState<DevilCostumeRequestForm> {
  final _formKey = GlobalKey<FormState>();
  // final String _selectedNumber = Constants.typeOfCustomRequest.keys.first;

  final bool _isChecked = false;
  int typeOfCostumeOption = 1;
  String? name;
  String? contact;
  String? address;
  List<DevilCostume> costumes = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Requisição de fato de diabo"),
            backgroundColor: Colors.teal,
            leading: const CloseButton(),
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
                            ConditionalParentWidget(
                              condition: isMobile(constraints),
                              children: [
                                BasicTextForm(
                                  title: "Nome:",
                                  isPhone: true,
                                  isRequired: true,
                                  onChanged: (value) {
                                    name = value;
                                  },
                                ),
                                const SizedBox(width: 16),
                                BasicTextForm(
                                  title: "Contacto: ",
                                  isPhone: true,
                                  isRequired: true,
                                  onChanged: (value) {
                                    contact = value;
                                  },
                                ),
                              ],
                            ),
                            BasicTextForm(
                                title: "Morada: ",
                                maxLines: 3,
                                isPhone: false,
                                isRequired: true,
                                onChanged: (value) {
                                  address = value;
                                })
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ConditionalParentWidget(
                          condition: isMobile(constraints),
                          children: [
                            const Text('Tipo de requisição:',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                )),
                            const SizedBox(width: 20),
                            ...Constants.typeOfCustomRequest.entries
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: ConditionalParentWidget(
                                        condition: isMobile(constraints),
                                        children: [
                                          Text(e.value),
                                          Radio(
                                            value: e.key,
                                            groupValue: typeOfCostumeOption,
                                            onChanged: (int? value) {
                                              setState(() {
                                                typeOfCostumeOption = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                    typeOfCostumeOption == 1 //rental
                        ? CostumeRental(
                            constraints: constraints,
                            reqType: Constants.typeOfCustomRequest.values
                                .toList()[typeOfCostumeOption - 1],
                          )
                        : typeOfCostumeOption == 2 //buy new
                            ? Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: BuyCostume(
                                      constraints: constraints,
                                      reqType: Constants
                                          .typeOfCustomRequest.values
                                          .toList()[typeOfCostumeOption - 1]),
                                ),
                              )
                            : Card(
                                //buy used
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: BuyCostume(
                                      constraints: constraints,
                                      reqType: Constants
                                          .typeOfCustomRequest.values
                                          .toList()[typeOfCostumeOption - 1]),
                                ),
                              )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    if (_formKey.currentState!.validate()) {
      ref.read(devilCostumeRequisitionProvider.notifier).add(
          DevilCostumeRequest(
              name: name!,
              phoneNumber: int.tryParse(contact!) ?? 0,
              costumes: ref.read(devilCostumeListProvider),
              deliveryDateLimit: DateTime.now().add(const Duration(days: 15)),
              requestDate: DateTime.now(),
              deliveryDate: null,
              status: RequisitionStatus.toBeDelivered,
              address: address!,
              devilCostumeRequestType:
                  DevilCustomUsage.values[typeOfCostumeOption]));
    }
    Navigator.pop(context);
  }
}
