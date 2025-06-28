import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/dependency_injection/service_locator.dart';
import 'package:medical/core/utils/assets.dart';

import 'package:medical/core/utils/styles.dart';
import 'package:medical/core/widgets/custom_elevated_button.dart';
import 'package:medical/features/cart/data/models/cart_model.dart';
import 'package:medical/features/cart/data/repository/cart_repository.dart';
import 'package:medical/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:medical/features/cart/presentation/cubit/cart_state.dart';

import 'package:medical/features/cart/presentation/view/widgets/cart_item_container.dart';
import 'package:medical/features/cart/presentation/view/widgets/payment_summery_row.dart';
import 'package:medical/features/checkout/presentation/view/checkout_screen.dart';
import 'package:medical/features/home/presentation/view/home.dart';
import 'package:sizer/sizer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // List<CartItemModel> cartItemModel = [
  //   CartItemModel(
  //     id: "1",
  //     productId: "1",
  //     imageUrl: AssetsData.medicine,

  //     price: 25,
  //     title: "Sugar free gold",
  //     subtitle: "bottle of 500 pellets",
  //     quantity: 3,
  //   ),
  //   CartItemModel(
  //     id: "1",
  //     productId: "1",
  //     imageUrl: AssetsData.medicine2,

  //     price: 25,
  //     title: "Sugar free gold",
  //     subtitle: "bottle of 500 pellets",
  //     quantity: 3,
  //   ),
  // ];
  int portion = 1;

  double calculateTotalCartPrice(List<CartItemModel> cartItems) {
    return cartItems.fold(
      0.0,
      (total, item) => total + (item.price * item.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(sl.get<CartRepository>())..loadCart(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(ConstantText.yourCart, style: Styles.textStyle16),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CartError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: Styles.textStyle14.copyWith(color: Colors.red),
                    ),
                  );
                } else if (state is CartUpdated) {
                  if (state.cartItems.isEmpty) {
                    return _emptyCart();
                  }

                  return Padding(
                    padding: EdgeInsets.all(1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${state.cartItems.length} Items in your cart",
                              style: Styles.textStyle14.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onDoubleTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomeScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.add),
                                  Text(
                                    ConstantText.addMore,
                                    style: Styles.textStyle14.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        ListView.builder(
                          itemBuilder: (_, index) {
                            final item = state.cartItems[index];
                            return CartItemContainer(
                              imageName:
                                  AssetsData.productImage1, //update image
                              title: item.productId,
                              price: "Rs.${item.price}",
                              portion: item.quantity,
                              removeItemCart: () {
                                context.read<CartCubit>().removeItemFromCart(
                                  (item.id),
                                );
                              },
                              onTapAdd: () {
                                setState(() {
                                  item.quantity++;
                                });
                              },
                              onTapRemove: () {
                                setState(() {
                                  if (item.quantity > 0) item.quantity--;
                                });
                              },
                            );
                          },
                          itemCount: state.cartItems.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          ConstantText.paymentSummary,
                          style: Styles.textStyle16.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        PaymentSummaryRow(
                          title: ConstantText.orderTotal,
                          value: calculateTotalCartPrice(
                            state.cartItems,
                          ).toString(),
                        ),
                        PaymentSummaryRow(
                          title: ConstantText.shipping,
                          value: "Free",
                        ),
                        PaymentSummaryRow(
                          title: ConstantText.total,
                          value:
                              "RS.${calculateTotalCartPrice(state.cartItems)}",
                          textStyle: Styles.textStyle16,
                        ),
                        SizedBox(height: 6.h),
                        CustomElevatedButton(
                          buttonText: ConstantText.placeOrder,
                          onPressedFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckoutScreen(
                                  cartItemModel: state.cartItems,
                                  total: calculateTotalCartPrice(
                                    state.cartItems,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return _emptyCart();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyCart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(height: 20.h),
        Image.asset(AssetsData.cart),
        SizedBox(height: 5.h),
        Text(
          ConstantText.whoops,
          style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 3.h),
        Text(
          ConstantText.yourCartEmpty,
          style: Styles.textStyle14.copyWith(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
