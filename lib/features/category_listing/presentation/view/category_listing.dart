import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/dependency_injection/service_locator.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/category_listing/data/models/all_product_model.dart';
import 'package:medical/features/category_listing/data/repository/all_product_repository.dart';
import 'package:medical/features/category_listing/presentation/cubit/all_product_cubit.dart';
import 'package:medical/features/category_listing/presentation/cubit/all_product_states.dart';
import 'package:medical/features/category_listing/presentation/view/widgets/product_item.dart';
import 'package:medical/features/home/presentation/view/widget/gridview_builder.dart';
import 'package:medical/features/product_details/presentation/view/product_details.dart';
import 'package:sizer/sizer.dart';

class CategoryListing extends StatelessWidget {
  const CategoryListing({super.key});
  // final List<CategoryModel> categories = [
  //   CategoryModel(
  //     imageUrl: AssetsData.medicine,
  //     title: "Sugar\n Substitute",
  //     description: "",
  //   ),
  //   CategoryModel(
  //     imageUrl: AssetsData.medicine2,
  //     title: "Juices &\n Vinegars",
  //     description: "",
  //   ),
  //   CategoryModel(
  //     imageUrl: AssetsData.medicine3,
  //     title: "Vitamins\n Medicines",
  //     description: "",
  //   ),  // ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AllProductCubit(sl<AllProductRepository>())..getProducts(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(ConstantText.diabetesCare, style: Styles.textStyle16),

          elevation: 0,
        ),

        body: SingleChildScrollView(
          child: BlocBuilder<AllProductCubit, AllProductState>(
            builder: (context, state) {
              if (state is AllProductLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is AllProductError) {
                return Center(child: Text(state.message));
              } else if (state is AllProductLoaded) {
                final categories = state.products;
                if (categories.isEmpty) {
                  return Center(child: Text("No data available"));
                }
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ConstantText.categories, style: Styles.textStyle16),
                      SizedBox(height: 2.h),
                      SizedBox(
                        height: 25.h,
                        child: ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 3.w),
                              child: Column(
                                children: [
                                  Container(
                                    width: 30.w,
                                    height: 15.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          categories[index].imageUrl ??
                                              "https://medical.digital-vision-solutions.com/storage/image.png",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    categories[index].category.name,
                                    textAlign: TextAlign.center,
                                    style: Styles.textStyle13,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(ConstantText.allProduct, style: Styles.textStyle16),
                      SizedBox(height: 5.h),
                      SizedBox(
                        height: 70.h,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                childAspectRatio: 0.87,
                              ),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return ProductItem(
                              onTap: () {
                                // Navigate to product details page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                      productId: categories[index].id,
                                    ),
                                  ),
                                );
                              },
                              productId: categories[index].id,
                              badge: "SALE",
                              imageUrl:
                                  categories[index].imageUrl ??
                                  AssetsData.productImage1,
                              title: categories[index].name,
                              price: "RS. ${categories[index].newPrice}",
                              rating: categories[index].rating.toString(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: Text("No data available"));
              }
            },
          ),
        ),
      ),
    );
  }
}
