import 'package:flutter/material.dart';
import 'package:medical/core/utils/colors.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/cart/presentation/view/widgets/add_remove_item.dart';
import 'package:sizer/sizer.dart';

class CartItemContainer extends StatelessWidget {
  const CartItemContainer({
    super.key,
    required this.imageName,
    required this.title,
    // required this.subTitle,
    required this.price,
    this.onTapAdd,
    this.onTapRemove,
    required this.portion,
    required this.removeItemCart,
  });
  final String imageName;
  final String title;
  // final String subTitle;
  final String price;
  final void Function()? onTapAdd;
  final void Function()? onTapRemove;
  final void Function()? removeItemCart;
  final int portion;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: 20.w,
            height: 24.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageName,
                fit: BoxFit.cover,
              ), //make it network
            ),
          ),

          SizedBox(width: 4.w),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Close button row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Styles.textStyle14.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle remove item
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: removeItemCart,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 0.5.h),

                // Text(
                //   subTitle,
                //   style: Styles.textStyle13.copyWith(
                //     color: Colors.grey.shade600,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                SizedBox(height: 2.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: Styles.textStyle18.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AddRemoveContainer(
                            onTap: onTapRemove,
                            text: "-",
                            containerColor: ColorsHelper.lightGrey1,
                            borderColor: ColorsHelper.lightGrey1,
                            textColor: Colors.black,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              "$portion",
                              style: Styles.textStyle14.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          AddRemoveContainer(
                            onTap: onTapAdd,
                            text: "+",
                            containerColor: ColorsHelper.lightpurple,
                            borderColor: ColorsHelper.lightpurple,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
