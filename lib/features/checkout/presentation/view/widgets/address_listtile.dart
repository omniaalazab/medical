import 'package:flutter/material.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/checkout/presentation/view/widgets/edit_address_dailog.dart';
import 'package:medical/features/checkout/presentation/view/widgets/radio_button_choose_address.dart';

class AddressListTile extends StatelessWidget {
  final String title;
  final String addressLine1;
  final String addressLine2;
  final int index;
  final int selectedValue;
  final ValueChanged<int?> onChanged;
  final VoidCallback onEditPressed;
  final bool showRadioButton;
  final Widget? leading;
  const AddressListTile({
    super.key,
    required this.title,
    required this.addressLine1,
    required this.addressLine2,
    required this.index,
    required this.selectedValue,
    required this.onChanged,
    required this.onEditPressed,
    this.showRadioButton = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: showRadioButton
            ? RadioButtonAddress(
                index: index,
                selectedValue: selectedValue,
                onChanged: onChanged,
              )
            : leading,
        title: Text(
          title,
          style: Styles.textStyle14.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "$addressLine1\n$addressLine2",
          style: Styles.textStyle13.copyWith(fontWeight: FontWeight.w400),
        ),
        trailing: showRadioButton
            ? IconButton(icon: const Icon(Icons.edit), onPressed: onEditPressed)
            : RadioButtonAddress(
                onChanged: onChanged,
                selectedValue: selectedValue,
                index: index,
              ),
        onTap: showRadioButton
            ? () {
                onChanged(index);
              }
            : null,
      ),
    );
  }
}
