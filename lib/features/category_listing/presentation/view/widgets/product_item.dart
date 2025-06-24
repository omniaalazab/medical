import 'package:flutter/material.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/category_listing/presentation/view/widgets/triangle_sale.dart';
import 'package:medical/features/product_details/presentation/view/product_details.dart';
import 'package:sizer/sizer.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.badge,
  });
  final String badge;
  final String imageUrl;
  final String title;
  final String price;
  final String rating;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to product details page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetails()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(height: 4.h),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.asset(
                    imageUrl,
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: SaleRedTriangle(
                    color: badge == "SALE"
                        ? Colors.red
                        : Colors.yellow.shade700,
                    text: badge,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle13,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(price, style: Styles.textStyle16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              rating,
                              style: Styles.textStyle13.copyWith(
                                color: Colors.white,
                              ),
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
      ),
    );
  }
}
