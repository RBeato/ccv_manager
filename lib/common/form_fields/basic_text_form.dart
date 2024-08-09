import 'package:flutter/material.dart';

class BasicTextForm extends StatefulWidget {
  const BasicTextForm(
      {required this.title,
      this.maxLines,
      this.isPhone,
      this.isEmail,
      this.isNumber,
      this.initialValue,
      this.controller,
      required this.onChanged,
      required this.isRequired,
      super.key});

  final String title;
  final int? maxLines;
  final bool? isPhone;
  final bool? isEmail;
  final bool? isNumber;
  final TextEditingController? controller;
  final String? initialValue;
  final bool isRequired;
  final Function(String?) onChanged;

  @override
  State<BasicTextForm> createState() => _BasicTextFormState();
}

class _BasicTextFormState extends State<BasicTextForm> {
  late TextEditingController titleController;

  get maxLines => null;

  @override
  void initState() {
    super.initState();
    titleController = widget.controller ?? TextEditingController();

    if (widget.initialValue != null) {
      titleController.text = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          labelText: widget.title,
          border: const UnderlineInputBorder(),
          hintText: widget.title,
        ),
        onChanged: widget.onChanged,
        onFieldSubmitted: (_) {},
        validator: (value) {
          if (widget.isNumber == true && value != null && value.isNotEmpty) {
            if (double.tryParse(value) == null) {
              return 'Deve inserir um número válido';
            }
          }
          if (value != null && value.isEmpty && widget.isRequired == true) {
            return 'É necessário preencher o ${widget.title.toLowerCase()}';
          }
          return null;
        },
        controller: titleController,
        maxLines: maxLines != null
            ? 1
            : null, //*If maxLines is null, the text field is limited to one line.

        keyboardType: getKeyboardType());
  }

  getKeyboardType() {
    if (widget.isPhone == true) {
      return TextInputType.text;
    }
    if (widget.isEmail == true) {
      return TextInputType.emailAddress;
    }
    if (widget.isNumber == true) {
      return TextInputType.number;
    } else {
      return TextInputType.phone;
    }
  }
}
