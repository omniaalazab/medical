import 'package:flutter/material.dart';
import 'package:medical/core/models/product_model.dart';

import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/category_listing/presentation/view/category_listing.dart';

import 'package:sizer/sizer.dart';

class GridViewBuilder extends StatelessWidget {
  const GridViewBuilder({super.key, required this.productList});

  final List<ProductModel> productList;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //shrinkWrap: true,
      //physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.87,
      ),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryListing()),
            );
          },
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      productList[index].imageUrl ?? AssetsData.productImage1,
                      height: 15.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    productList[index].name ?? "",
                    style: Styles.textStyle10,
                  ),
                  Text(
                    productList[index].description ?? "",
                    style: Styles.textStyle10,
                  ),
                  Text(
                    "RS. ${productList[index].newPrice} ",
                    style: Styles.textStyle16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
