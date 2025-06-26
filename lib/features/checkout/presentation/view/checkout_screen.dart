import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/dependency_injection/service_locator.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/core/widgets/custom_elevated_button.dart';
import 'package:medical/features/cart/data/models/cart_model.dart';
import 'package:medical/features/checkout/data/models/address_model.dart';
import 'package:medical/features/checkout/presentation/view/widgets/address_listtile.dart';
import 'package:medical/features/checkout/presentation/view/widgets/edit_address_dailog.dart';
import 'package:medical/features/payment_sucess/data/repository/payment_repository.dart';
import 'package:medical/features/payment_sucess/presentation/cubit/payment_cubit.dart';
import 'package:medical/features/payment_sucess/presentation/cubit/payment_state.dart';
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
  PaymentRepository paymentRepository = sl<PaymentRepository>();
  int selectedValue = 0;
  final List<AddressModel> addresses = [
    AddressModel(
      id: '1',
      title: 'Office',
      addressLine1: '(205) 555-024',
      addressLine2: '1786 Wheeler Bridge',
      isDefault: true,
    ),
    AddressModel(
      id: '2',
      title: 'Home',
      addressLine1: '(205) 555-024',
      addressLine2: '1786 Wheeler Bridge',
    ),
  ];

  void _editAddress(int index) {
    final address = addresses[index];
    EditAddressDialog.showEditAddressDialog(
      context,
      initialTitle: address.title,
      initialAddress1: address.addressLine1,
      initialAddress2: address.addressLine2,
      onSave: (newTitle, newAddress1, newAddress2) {
        setState(() {
          addresses[index] = address.copyWith(
            title: newTitle,
            addressLine1: newAddress1,
            addressLine2: newAddress2,
          );
        });
      },
    );
  }

  void _addNewAddress() {
    EditAddressDialog.showEditAddressDialog(
      context,
      onSave: (title, address1, address2) {
        setState(() {
          addresses.add(
            AddressModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: title,
              addressLine1: address1,
              addressLine2: address2,
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(paymentRepository),
      child: Scaffold(
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

              // Display saved addresses
              ...addresses.asMap().entries.map((entry) {
                final index = entry.key;
                final address = entry.value;
                return Column(
                  children: [
                    AddressListTile(
                      title: address.title,
                      addressLine1: address.addressLine1,
                      addressLine2: address.addressLine2,
                      index: index,
                      selectedValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                      onEditPressed: () => _editAddress(index),
                    ),
                    SizedBox(height: 1.h),
                  ],
                );
              }),

              // Add new address button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.add),
                  TextButton(
                    onPressed: _addNewAddress,
                    child: Text(
                      ConstantText.addAddress,
                      style: Styles.textStyle14,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2.h),
              Text(ConstantText.paymentMethod, style: Styles.textStyle16),
              SizedBox(height: 2.h),

              // Payment method
              AddressListTile(
                title: ConstantText.cashOnDelivery,
                addressLine1: '',
                addressLine2: '',
                index: addresses.length, // Use next index after addresses
                selectedValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SucessPayment()),
                  );
                },
                onEditPressed: () {},
                showRadioButton: false,
                leading: Image.asset(
                  AssetsData.payment,
                  height: 4.h,
                  width: 4.h,
                ),
              ),

              const Spacer(),
              BlocConsumer<PaymentCubit, PaymentState>(
                listener: (context, state) {
                  if (state is PaymentSucess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SucessPayment()),
                    );
                  } else if (state is PaymentFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    buttonText: ConstantText.payNow,
                    onPressedFunction: () {
                      context.read<PaymentCubit>().makePayment(
                        courseId: "course123", // replace with actual course ID
                        amount: 5000, // in cents if using Stripe
                        currency: "usd",
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
