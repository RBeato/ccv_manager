import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee/marquee.dart';

import '../common/appbar_editing_save_button.dart';
import '../common/check_is_mobile.dart';
import '../events_widget/common/row_column_mobile_conditional_builder.dart';
import '../models/library_models/book_request.dart';
import '../models/devil_costumes/devil_costume_request.dart';
import 'providers/costume_requisition_provider.dart';

class CostumeRequestCardViewPage extends ConsumerStatefulWidget {
  const CostumeRequestCardViewPage(
      {required this.item, this.constraints, super.key});
  final DevilCostumeRequest item;
  final BoxConstraints? constraints;

  @override
  ConsumerState<CostumeRequestCardViewPage> createState() =>
      _CostumeRequestCardViewPageState();
}

class _CostumeRequestCardViewPageState
    extends ConsumerState<CostumeRequestCardViewPage> {
  final _formKey = GlobalKey<FormState>();
  int _selectedNumber = 1;
  bool _isChecked = false;

  final TextStyle _style = const TextStyle(
    color: Colors.black54,
    fontSize: 18,
  );

  final TextStyle _dataStyle = const TextStyle(
    color: Colors.black87,
    fontSize: 18,
  );

  @override
  void initState() {
    _selectedNumber = widget.item.costumes.length;
    _isChecked = widget.item.deliveryDate != null;
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 50,
            child: Marquee(text: "Ficha de requisição de fatos de diabo.   ")),
        backgroundColor: Colors.teal,
        leading: const CloseButton(),
        actions: buildEditingActions(() => saveForm(item)),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              Text('Nome', style: _style),
                              const SizedBox(width: 16),
                              Text(item.name, style: _dataStyle),
                            ],
                          ),
                        ),
                        ConditionalParentWidget(
                          condition: isMobile(widget.constraints),
                          children: [
                            Row(children: [
                              Text("Morada: ", style: _style),
                              Expanded(
                                  child: Text(
                                item.address,
                                style: _dataStyle,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ]),
                            Row(
                              children: [
                                Text("Contacto: ", style: _style),
                                Expanded(
                                  child: Text(
                                    item.phoneNumber.toString(),
                                    style: _dataStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ...getCostumeDataFormulary(),
                Card(
                  // elevation: 3,
                  shadowColor: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConditionalParentWidget(
                          condition: isMobile(widget.constraints),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Data de requisição: ", style: _style),
                                Expanded(
                                  child: Text(
                                      item.requestDate != null
                                          ? DateTimeUtils.toDateTimeString(
                                              item.requestDate!)
                                          : '',
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
                                      item.deliveryDateLimit != null
                                          ? DateTimeUtils.toDateTimeString(
                                              item.deliveryDateLimit!)
                                          : '',
                                      overflow: TextOverflow.ellipsis,
                                      style: _dataStyle),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text("Data de entrega: ", style: _style),
                                  Expanded(
                                    child: Text(
                                        item.deliveryDate == null
                                            ? ""
                                            : DateTimeUtils.toDateTimeString(
                                                item.deliveryDate!,
                                              ),
                                        overflow: TextOverflow.ellipsis,
                                        style: _dataStyle),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: CheckboxListTile(
                    title: Text("Entregue", style: _dataStyle),
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                        if (_isChecked) {
                          item.deliveryDate = DateTime.now();
                        } else {
                          item.deliveryDate = null;
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getCostumeDataFormulary() {
    List<Widget> temp = [];

    temp.add(Card(
      shadowColor: Colors.grey,
      // elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            children: widget.item.costumes
                .map((c) => Row(children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text("Tamanho: ", style: _style),
                            Text(c.size, style: _dataStyle),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text("Quantidade: ", style: _style),
                            Text(c.quantity.toString(), style: _dataStyle),
                          ],
                        ),
                      ),
                    ]))
                .toList()),
      ),
    ));

    return temp;
  }

  Future saveForm(DevilCostumeRequest item) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    if (_formKey.currentState!.validate()) {
      if (_isChecked) {
        //   ref.read(devilCostumeRequisitionProvider.notifier).add(item.copyWith(
        //         deliveryDate: null,
        //         status: RequisitionStatus.toBeDelivered,
        //       ));
        // } else {
        ref.read(devilCostumeRequisitionProvider.notifier).edit(item.copyWith(
            deliveryDate: DateTime.now(), status: RequisitionStatus.delivered));
      }
      Navigator.of(context).pop();
    }
  }
}
