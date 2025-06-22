import 'package:flutter/material.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/assets.dart';

import 'package:medical/core/utils/styles.dart';
import 'package:medical/core/widgets/custom_elevated_button.dart';
import 'package:medical/features/cart/data/cart_model.dart';

import 'package:medical/features/cart/presentation/view/widgets/cart_item_container.dart';
import 'package:medical/features/cart/presentation/view/widgets/payment_summery_row.dart';
import 'package:sizer/sizer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<CartItemModel> cartModel = [
    CartItemModel(
      id: "1",
      productId: "1",
      imageUrl: AssetsData.medicine,
      originalPrice: 25,
      price: 25,
      title: "Sugar free gold",
      subtitle: "bottle of 500 pellets",
      quantity: 3,
    ),
    CartItemModel(
      id: "1",
      productId: "1",
      imageUrl: AssetsData.medicine2,
      originalPrice: 25,
      price: 25,
      title: "Sugar free gold",
      subtitle: "bottle of 500 pellets",
      quantity: 3,
    ),
  ];
  int portion = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ConstantText.yourCart), elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("2 Items in your cart", style: Styles.textStyle14),
                  Spacer(),
                  IconButton(icon: Icon(Icons.add), onPressed: () {}),
                  Text("Add more", style: Styles.textStyle14),
                ],
              ),
              SizedBox(height: 2.h),
              ListView.builder(
                itemBuilder: (_, index) {
                  final item = cartModel[index];
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
                itemCount: cartModel.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),

              SizedBox(height: 5.h),
              Text(
                ConstantText.paymentSummary,
                style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              PaymentSummaryRow(title: "Order Total", value: "228.80"),
              PaymentSummaryRow(title: "Items Discount", value: "- 28.80"),
              PaymentSummaryRow(title: "Coupon Discount", value: "-15.80"),

              PaymentSummaryRow(title: "Shipping", value: "Free"),
              PaymentSummaryRow(
                title: "Total",
                value: "-Rs.185.00",
                textStyle: Styles.textStyle16,
              ),
              SizedBox(height: 2.h),
              CustomElevatedButton(
                buttonText: "Place Order",
                onPressedFunction: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
