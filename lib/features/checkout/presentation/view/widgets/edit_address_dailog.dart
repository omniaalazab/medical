import 'package:flutter/material.dart';
import 'package:medical/core/constant_text.dart';

class EditAddressDialog {
  static Future showEditAddressDialog(
    BuildContext context, {
    String initialTitle = '',
    String initialAddress1 = '',
    String initialAddress2 = '',
    required Function(String, String, String) onSave,
  }) {
    final titleController = TextEditingController(text: initialTitle);
    final address1Controller = TextEditingController(text: initialAddress1);
    final address2Controller = TextEditingController(text: initialAddress2);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(ConstantText.editAdress),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Address Title (e.g., Home, Office)',
                  ),
                ),
                TextField(
                  controller: address1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Address Line 1',
                  ),
                ),
                TextField(
                  controller: address2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Address Line 2',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final address1 = address1Controller.text.trim();
                final address2 = address2Controller.text.trim();

                if (title.isNotEmpty && address1.isNotEmpty) {
                  onSave(title, address1, address2);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
