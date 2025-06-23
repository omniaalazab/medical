import 'package:flutter/material.dart';
import 'package:medical/core/constant_text.dart';

class EditAddressDialog {
  static Future showErrorDialogDefult(
    TextEditingController addressController,
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(ConstantText.editAdress),
          content: TextField(
            controller: addressController,
            decoration: InputDecoration(hintText: 'Enter new address'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String newAddress = addressController.text.trim();

                if (newAddress.isNotEmpty) {
                  print('New Address: $newAddress');

                  Navigator.pop(context);
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
