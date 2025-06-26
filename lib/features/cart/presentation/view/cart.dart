import 'package:flutter/material.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/assets.dart';

import 'package:medical/core/utils/styles.dart';
import 'package:medical/core/widgets/custom_elevated_button.dart';
import 'package:medical/features/cart/data/models/cart_model.dart';

import 'package:medical/features/cart/presentation/view/widgets/cart_item_container.dart';
import 'package:medical/features/cart/presentation/view/widgets/payment_summery_row.dart';
import 'package:medical/features/checkout/presentation/view/checkout_screen.dart';
import 'package:sizer/sizer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<CartItemModel> cartItemModel = [
    CartItemModel(
      id: "1",
      productId: "1",
      imageUrl: AssetsData.medicine,

      price: 25,
      title: "Sugar free gold",
      subtitle: "bottle of 500 pellets",
      quantity: 3,
    ),
    CartItemModel(
      id: "1",
      productId: "1",
      imageUrl: AssetsData.medicine2,

      price: 25,
      title: "Sugar free gold",
      subtitle: "bottle of 500 pellets",
      quantity: 3,
    ),
  ];
  int portion = 1;

  double calculateTotalCartPrice(List<CartItemModel> cartItems) {
    return cartItems.fold(
      0.0,
      (total, item) => total + (item.price * item.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ConstantText.yourCart, style: Styles.textStyle16),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${cartItemModel.length} Items in your cart",
                    style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  IconButton(icon: Icon(Icons.add), onPressed: () {}),
                  Text(
                    ConstantText.addMore,
                    style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              ListView.builder(
                itemBuilder: (_, index) {
                  final item = cartItemModel[index];
                  return CartItemContainer(
                    imageName: item.imageUrl,
                    title: item.title,
                    subTitle: item.subtitle,
                    price: "Rs.${item.price}",
                    portion: item.quantity,
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
                itemCount: cartItemModel.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),

              SizedBox(height: 5.h),
              Text(
                ConstantText.paymentSummary,
                style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 2.h),
              PaymentSummaryRow(
                title: ConstantText.orderTotal,
                value: calculateTotalCartPrice(cartItemModel).toString(),
              ),
              PaymentSummaryRow(
                title: ConstantText.itemsDiscount,
                value: "- 28.80",
              ),
              PaymentSummaryRow(
                title: ConstantText.couponDiscount,
                value: "-15.80",
              ),

              PaymentSummaryRow(title: ConstantText.shipping, value: "Free"),
              PaymentSummaryRow(
                title: ConstantText.total,
                value: "RS.${calculateTotalCartPrice(cartItemModel)}",
                textStyle: Styles.textStyle16,
              ),
              SizedBox(height: 2.h),
              CustomElevatedButton(
                buttonText: ConstantText.placeOrder,
                onPressedFunction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CheckoutScreen(
                        cartItemModel: cartItemModel,
                        total: calculateTotalCartPrice(cartItemModel),
                      ),
                    ),
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
