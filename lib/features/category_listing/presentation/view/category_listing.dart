import 'package:flutter/material.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/category_listing/data/category_model.dart';
import 'package:medical/features/category_listing/presentation/view/widgets/product_item.dart';
import 'package:sizer/sizer.dart';

class CategoryListing extends StatelessWidget {
  CategoryListing({super.key});
  final List<CategoryModel> categories = [
    CategoryModel(
      imageUrl: AssetsData.medicine,
      title: "Sugar\n Substitute",
      description: "",
    ),
    CategoryModel(
      imageUrl: AssetsData.medicine2,
      title: "Juices &\n Vinegars",
      description: "",
    ),
    CategoryModel(
      imageUrl: AssetsData.medicine3,
      title: "Vitamins\n Medicines",
      description: "",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
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
                                image: AssetImage(categories[index].imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            categories[index].title,
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
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: .8,
                  children: [
                    ProductItem(
                      badge: "SALE",
                      imageUrl: AssetsData.productImage,
                      title: "Accu-check Active Test Strip",
                      price: "Rs.112",
                      rating: "4.2",
                    ),
                    ProductItem(
                      badge: "35% OFF",
                      imageUrl: AssetsData.productImage1,
                      title: "Omron HEM-8712 BP Monitor",
                      price: "Rs.150",
                      rating: "4.2",
                    ),
                    ProductItem(
                      badge: "35% OFF",
                      imageUrl: AssetsData.productImage,
                      title: "Omron HEM-8712 BP Monitor",
                      price: "Rs.150",
                      rating: "4.2",
                    ),
                    ProductItem(
                      badge: "SALE",
                      imageUrl: AssetsData.productImage1,
                      title: "Accu-check Active Test Strip",
                      price: "Rs.112",
                      rating: "4.2",
                    ),
                    ProductItem(
                      badge: "35% OFF",
                      imageUrl: AssetsData.productImage,
                      title: "Omron HEM-8712 BP Monitor",
                      price: "Rs.150",
                      rating: "4.2",
                    ),
                    ProductItem(
                      badge: "35% OFF",
                      imageUrl: AssetsData.productImage,
                      title: "Omron HEM-8712 BP Monitor",
                      price: "Rs.150",
                      rating: "4.2",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
