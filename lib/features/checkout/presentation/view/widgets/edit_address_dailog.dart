import 'package:flutter/material.dart';

import 'package:medical/features/checkout/data/models/address_model.dart';

class EditAddressDialog {
  static void showEditAddressDialog(
    BuildContext context, {
    AddressModel? existingAddress,
    required Function(String, String, String) onSave,
  }) {
    final titleController = TextEditingController(
      text: existingAddress?.title ?? '',
    );
    final address1Controller = TextEditingController(
      text: existingAddress?.addressLine1 ?? '',
    );
    final address2Controller = TextEditingController(
      text: existingAddress?.addressLine2 ?? '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(existingAddress == null ? 'Add Address' : 'Edit Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: address1Controller,
                decoration: InputDecoration(labelText: 'Address Line 1'),
              ),
              TextField(
                controller: address2Controller,
                decoration: InputDecoration(labelText: 'Address Line 2'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onSave(
                  titleController.text,
                  address1Controller.text,
                  address2Controller.text,
                );
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
