import 'package:flutter/material.dart';

List<Widget> buildEditingActions(Function saveForm) {
  return [
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal.withOpacity(0.9),
          shadowColor: Colors.black),
      icon: const Icon(Icons.done),
      label: const Text("GUARDAR"),
      onPressed: () async {
        await saveForm();
      },
    ),
  ];
}
