import 'package:flutter/material.dart';
import 'package:medical/features/checkout/presentation/view/widgets/edit_address_dailog.dart';
import 'package:medical/features/checkout/presentation/view/widgets/radio_button_choose_address.dart';

class AddressTile extends StatelessWidget {
  final TextEditingController address;
  final TextEditingController addressDetail;
  final void Function(int?)? onAddressChanged;
  final void Function(int?)? onChanged;
  final BuildContext context;
  final int index;
  final int selectedValue;
  const AddressTile({
    super.key,
    required this.address,
    required this.onAddressChanged,
    required this.context,
    required this.addressDetail,
    required this.index,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: RadioButtonAddress(
          index: index + 1,
          selectedValue: selectedValue,
          onChanged: onChanged,
        ),
        title: Text(
          address.text.isEmpty ? 'No Address Yet' : address.text,
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          addressDetail.text.isEmpty ? 'No Address Yet' : addressDetail.text,
          style: TextStyle(fontSize: 16),
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            EditAddressDialog.showErrorDialogDefult(address, context);
          },
        ),
      ),
    );
  }
}
