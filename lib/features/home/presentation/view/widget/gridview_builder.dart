import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/core/models/product_model/product_model.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/category_listing/presentation/view/category_listing.dart';
import 'package:medical/features/home/data/cubit/cubit/product_cubit.dart';

import 'package:sizer/sizer.dart';

class GridViewBuilder extends StatelessWidget {
  const GridViewBuilder({super.key, required this.productList});

  final List<ProductUnifiedModel> productList;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
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
                        child: Image.network(
                          productList[index].data!.imageUrl ??
                              "https://tse3.mm.bing.net/th/id/OIP.qFBlyuJZmGuKfH_4xG2HpQAAAA?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
                          height: 15.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        productList[index].data!.name ?? "product name",
                        style: Styles.textStyle10,
                      ),
                      Text(
                        productList[index].data!.description ?? "",
                        style: Styles.textStyle10,
                      ),
                      Text(
                        "RS. ${productList[index].data!.newPrice}",
                        style: Styles.textStyle16,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
