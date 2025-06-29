import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/dependency_injection/service_locator.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/core/widgets/custom_elevated_button.dart';
import 'package:medical/features/cart/data/models/cart_model.dart';
import 'package:medical/features/checkout/data/models/address_model.dart';
import 'package:medical/features/checkout/data/repository/address_repository.dart';
import 'package:medical/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:medical/features/checkout/presentation/cubit/address_states.dart';
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
  int selectedValue = -1; // Initialize with -1 to indicate no selection
  int selectedAddressIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaymentCubit(sl<PaymentRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              AddressCubit(sl<AddressRepository>())..fetchAddresses(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text(ConstantText.checkout), elevation: 0),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            children: [
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  if (state is AddressLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is AddressError) {
                    return Center(child: Text(state.message));
                  } else if (state is AddressLoaded) {
                    selectedAddressIndex = state.addresses.length;

                    return ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 40.h),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          // cart info
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
                                  Text(
                                    ConstantText.total,
                                    style: Styles.textStyle13,
                                  ),
                                  Text(
                                    'RS.${widget.total}',
                                    style: Styles.textStyle16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            ConstantText.deliveryAddress,
                            style: Styles.textStyle16,
                          ),
                          SizedBox(height: 1.h),

                          ...state.addresses.asMap().entries.map((entry) {
                            final index = entry.key;
                            final address = entry.value;
                            debugPrint(
                              'Address ID: ${address.id}, Type: ${address.id.runtimeType}',
                            );
                            debugPrint(
                              'Index: $index, Type: ${index.runtimeType}',
                            );

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: AddressListTile(
                                title: address.title,
                                addressLine1: address.addressLine1,
                                addressLine2: address.addressLine2,
                                index: index,
                                selectedValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    // Safe type handling
                                    if (value != null) {
                                      selectedValue = value;
                                    }
                                  });
                                },
                                onEditPressed: () {
                                  EditAddressDialog.showEditAddressDialog(
                                    context,
                                    onSave: (title, address1, address2) {
                                      // Ensure isDefault is explicitly set to false
                                      final newAddress = AddressModel(
                                        isDefault:
                                            false, // Explicitly set to false
                                        id: DateTime.now()
                                            .millisecondsSinceEpoch,
                                        title: title,
                                        addressLine1: address1,
                                        addressLine2: address2,
                                      );

                                      debugPrint(
                                        'Creating new address: ${newAddress.toCreateJson()}',
                                      );
                                      context.read<AddressCubit>().addAddress(
                                        newAddress,
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.add),
                              TextButton(
                                onPressed: () {
                                  EditAddressDialog.showEditAddressDialog(
                                    context,
                                    onSave: (title, address1, address2) {
                                      context.read<AddressCubit>().addAddress(
                                        AddressModel(
                                          isDefault: false,
                                          id: DateTime.now()
                                              .millisecondsSinceEpoch, // Generate unique ID
                                          title: title,
                                          addressLine1: address1,
                                          addressLine2: address2,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  ConstantText.addAddress,
                                  style: Styles.textStyle14,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 2.h),
                          Text(
                            ConstantText.paymentMethod,
                            style: Styles.textStyle16,
                          ),
                        ],
                      ),
                    );
                  }

                  return Center(child: Text('No addresses found'));
                },
              ),
              SizedBox(height: 2.h),

              AddressListTile(
                title: ConstantText.cashOnDelivery,
                addressLine1: '',
                addressLine2: '',
                index: selectedAddressIndex,
                selectedValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      selectedValue = value;
                    }
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
                        courseId: "course123",
                        amount: 5000,
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
