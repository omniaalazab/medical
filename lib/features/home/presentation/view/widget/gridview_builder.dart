import 'package:flutter/material.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/product_details/data/product_model.dart';
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
          onTap: () {},
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Hero(
                      tag: productList[index].id,
                      child: Image.asset(
                        productList[index].imageUrl,
                        height: 15.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    productList[index].productName,
                    style: Styles.textStyle10,
                  ),
                  Text(
                    productList[index].productDescription,
                    style: Styles.textStyle10,
                  ),
                  Text(
                    "RS. ${productList[index].newPrice} ",
                    style: Styles.textStyle16,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Icon(Icons.star, color: Colors.amber),
                  //     Text(
                  //       "${productList[index].rate}",
                  //       style: TextStyleHelper.textStyleRoboto16,
                  //     ),
                  //     Spacer(),
                  //     Icon(
                  //       Icons.favorite_border_rounded,
                  //       color: sandwichModel[index].isFavorite == true
                  //           ? ColorHelper.red
                  //           : ColorHelper.black,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
