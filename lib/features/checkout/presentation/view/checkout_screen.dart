import 'package:flutter/material.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/colors.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/core/widgets/custom_elevated_button.dart';
import 'package:medical/features/cart/data/cart_model.dart';
import 'package:medical/features/checkout/presentation/view/widgets/address_listtile.dart';
import 'package:medical/features/checkout/presentation/view/widgets/edit_address_dailog.dart';
import 'package:medical/features/checkout/presentation/view/widgets/radio_button_choose_address.dart';
import 'package:medical/features/payment_sucess/presentation/view/sucess_payment.dart';
import 'package:sizer/sizer.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.cartItemModel,
    required this.total,
  });
  final List<CartItemModel> cartItemModel;
  final double total;
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController addressDetailController = TextEditingController();

  int index = 0;
  int selectedValue = 0;
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(ConstantText.checkout), elevation: 0),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.cartItemModel.length} Items in your cart",
                  style: Styles.textStyle14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(ConstantText.total, style: Styles.textStyle13),
                    Text('RS.${widget.total}', style: Styles.textStyle16),
                  ],
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(ConstantText.deliveryAddress, style: Styles.textStyle16),
            Card(
              elevation: 0,
              child: ListTile(
                leading: RadioButtonAddress(
                  index: index,
                  selectedValue: selectedValue,
                  onChanged: (int? value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                ),
                title: Text(
                  "office",
                  style: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "(205) 555-024\n1786 Wheeler Bridge",
                  style: Styles.textStyle13.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    EditAddressDialog.showErrorDialogDefult(
                      addressController,
                      context,
                    );
                  },
                ),
                onTap: () {
                  setState(() {
                    selectedValue = index;
                  });
                },
              ),
            ),
            SizedBox(height: 2.h),
            // AddressTile(
            //   address: addressController,
            //   addressDetail: addressDetailController,
            //   onAddressChanged: (value) {
            //     // Handle address change if needed
            //   },
            //   context: context,
            //   index: index,
            //   selectedValue: selectedValue,
            //   onChanged: (int? value) {
            //     setState(() {
            //       selectedValue = value!;
            //     });
            //   },
            // ),
            Card(
              elevation: 0,
              child: ListTile(
                leading: RadioButtonAddress(
                  index: index + 1,
                  selectedValue: selectedValue,
                  onChanged: (int? value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                ),
                title: Text(
                  "Home",
                  style: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "(205) 555-024\n1786 Wheeler Bridge",
                  style: Styles.textStyle13.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    EditAddressDialog.showErrorDialogDefult(
                      addressController,
                      context,
                    );
                  },
                ),
                onTap: () {
                  setState(() {
                    selectedValue = index;
                  });
                },
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.add),
                TextButton(
                  child: Text(
                    ConstantText.addAddress,
                    style: Styles.textStyle14,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(ConstantText.paymentMethod, style: Styles.textStyle16),
            SizedBox(height: 2.h),
            Card(
              elevation: 0,
              child: ListTile(
                leading: Image.asset(
                  AssetsData.payment,
                  height: 4.h,
                  width: 4.h,
                ),
                title: Text(
                  ConstantText.cashOnDelivery,
                  style: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: RadioButtonAddress(
                  index: index + 2,
                  selectedValue: selectedValue,
                  onChanged: (int? value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 2.h),
            CustomElevatedButton(
              buttonText: ConstantText.payNow,
              onPressedFunction: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SucessPayment()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
