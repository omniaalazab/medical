import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/colors.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/core/widgets/custom_elevated_button.dart';
import 'package:medical/features/cart/presentation/view/cart.dart';
import 'package:medical/features/notification/presentation/view/notification.dart';
import 'package:medical/core/dependency_injection/service_locator.dart';
import 'package:medical/core/models/product_model.dart';
import 'package:medical/features/product_details/presentation/cubit/product_cubit.dart';
import 'package:medical/features/product_details/presentation/cubit/product_state.dart';
import 'package:medical/features/product_details/presentation/view/widget/container_package_size.dart';
import 'package:medical/features/product_details/presentation/view/widget/rating_analyzing_row.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.productId});
  final int productId;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final PageController productController = PageController();
  bool islastPage = false;

  List<ProductModel> productModel = [
    ProductModel(
      id: 1,
      description: "Brandv",
      name: "Brandv",
      imageUrl: AssetsData.maskGroup,
      oldPrice: 100,
      newPrice: 80,
      isActive: true,
      brand: Brand(id: 1, name: "Brand1"),
      category: Category(id: 1, name: "Brand1"),
      expiryDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      createdAt: DateTime.now().toIso8601String(),
      productionDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      unit: Unit(id: 1, name: "name", symbol: "symbol"),
      updatedAt: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      reviews: [],
      reviewSummary: ReviewSummary(
        averageRating: 4.2,
        totalReviews: 15,
        ratings: Ratings(
          fiveStar: 4,
          fourStar: 5,
          threeStar: 5,
          twoStar: 5,
          oneStar: 4,
        ),
      ),
      ingredients: [
        Ingredient(id: 4, name: "name", description: "description"),
      ],
    ),
    ProductModel(
      id: 2,
      description: "Brandv",
      name: "Brandv",
      imageUrl: AssetsData.maskGroup,
      oldPrice: 100,
      newPrice: 80,
      isActive: true,
      brand: Brand(id: 1, name: "Brand1"),
      category: Category(id: 1, name: "Brand1"),
      expiryDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      createdAt: DateTime.now().toIso8601String(),
      productionDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      unit: Unit(id: 1, name: "name", symbol: "symbol"),
      updatedAt: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      reviews: [],
      reviewSummary: ReviewSummary(
        averageRating: 4.2,
        totalReviews: 15,
        ratings: Ratings(
          fiveStar: 4,
          fourStar: 5,
          threeStar: 5,
          twoStar: 5,
          oneStar: 4,
        ),
      ),
      ingredients: [
        Ingredient(id: 4, name: "name", description: "description"),
      ],
    ),
    ProductModel(
      id: 3,
      description: "Brandv",
      name: "Brandv",
      imageUrl: AssetsData.maskGroup,
      oldPrice: 100,
      newPrice: 80,
      isActive: true,
      brand: Brand(id: 1, name: "Brand1"),
      category: Category(id: 1, name: "Brand1"),
      expiryDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      createdAt: DateTime.now().toIso8601String(),
      productionDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      unit: Unit(id: 1, name: "name", symbol: "symbol"),
      updatedAt: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      reviews: [],
      reviewSummary: ReviewSummary(
        averageRating: 4.2,
        totalReviews: 15,
        ratings: Ratings(
          fiveStar: 4,
          fourStar: 5,
          threeStar: 5,
          twoStar: 5,
          oneStar: 4,
        ),
      ),
      ingredients: [
        Ingredient(id: 4, name: "name", description: "description"),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductDetailsCubit>()..fetchProductById(1),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {},
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => NotificationScreen()),
                    );
                  },
                  child: SvgPicture.asset(AssetsData.notifications),
                ),
                SizedBox(width: 2.w),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CartView()),
                    );
                  },
                  child: SvgPicture.asset(AssetsData.shoppingBag),
                ),
              ],
            ),
          ],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: BlocBuilder<ProductDetailsCubit, ProductStates>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                } else if (state is ProductSucces) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ConstantText.sugarFree, style: Styles.textStyle22),
                      Text(
                        ConstantText.sugarFreeDescription,
                        style: Styles.textStyle14,
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        height: 20.h,
                        child: PageView.builder(
                          controller: productController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: productModel.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Image.asset(
                                productModel[index].imageUrl,
                                height: 20.h,
                                width: 30.w,
                              ),
                            );
                          },
                          onPageChanged: (value) {
                            if (value == productModel.length - 1) {
                              setState(() {
                                islastPage = true;
                              });
                            } else {
                              setState(() {
                                islastPage = false;
                              });
                            }
                          },
                        ),
                      ),
                      Center(
                        child: SmoothPageIndicator(
                          onDotClicked: (index) {
                            productController.jumpToPage(index);
                          },
                          controller: productController,
                          count: productModel.length,
                          effect: WormEffect(
                            dotHeight: 1.h,
                            dotWidth: 2.w,
                            dotColor: Colors.grey,
                            activeDotColor: ColorsHelper.blue,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    ConstantText.oldPrice, //from API
                                    style: Styles.textStyle18.copyWith(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),

                                  Text(
                                    ConstantText.newPrice, //from API
                                    style: Styles.textStyle18.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Etiam mollis ",
                                style: Styles.textStyle18.copyWith(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 2.h),
                          Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(AssetsData.addCart),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(ConstantText.addToCart),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Divider(
                        indent: 2.h,
                        endIndent: 2.h,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(height: 2.h),
                      Text(ConstantText.packageSize, style: Styles.textStyle18),
                      Row(
                        children: [
                          ContainerPackageSize(
                            textColor: ColorsHelper.amber,
                            borderColor: ColorsHelper.amber,
                            price: "Rs.100",
                            noPallets: "500 pellets",
                          ),
                          ContainerPackageSize(
                            price: "Rs.166",
                            noPallets: "110 pellets",
                          ),
                          ContainerPackageSize(
                            price: "Rs.252",
                            noPallets: "300 pellets",
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        ConstantText.productDetails,
                        style: Styles.textStyle16,
                      ),
                      Text(
                        state.product.description,
                        style: Styles.textStyle14.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(ConstantText.ingredients, style: Styles.textStyle16),
                      Text(
                        state.product.ingredients[widget.productId].description,
                        style: Styles.textStyle14.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      SizedBox(height: 4.h),
                      _buildDateBrandRow(
                        title: ConstantText.expiryDate,
                        value: state.product.expiryDate,
                      ),
                      SizedBox(height: 1.h),
                      _buildDateBrandRow(
                        title: ConstantText.brandName,
                        value: state.product.brand.name,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${state.product.reviewSummary.averageRating}",
                                    style: Styles.textStyle33,
                                  ),
                                  SizedBox(width: 2.w),
                                  Icon(
                                    Icons.star,
                                    color: ColorsHelper.amber,
                                    size: 30,
                                  ),
                                ],
                              ),
                              Text(
                                "${state.product.reviewSummary.ratings} Ratings",
                                style: Styles.textStyle14,
                              ),
                              Text(
                                "and ${state.product.reviewSummary.totalReviews} Reviews",
                                style: Styles.textStyle14,
                              ),
                            ],
                          ),
                          SizedBox(width: 4.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30.h,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return RatingAnalyzingRow(
                                      ratingNo: "${5 - index}",
                                      valueLinearProgressIndicator:
                                          state
                                              .product
                                              .reviewSummary
                                              .averageRating /
                                          100,
                                      ratePrecentage:
                                          "${state.product.reviewSummary.averageRating}%",
                                    );
                                  },
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                ),
                              ),
                              // RatingAnalyzingRow(
                              //   ratingNo: "4",
                              //   valueLinearProgressIndicator: .67,
                              //   ratePrecentage: "67%",
                              // ),
                              // RatingAnalyzingRow(
                              //   ratingNo: "4",
                              //   valueLinearProgressIndicator: .2,
                              //   ratePrecentage: "20%",
                              // ),
                              // RatingAnalyzingRow(
                              //   ratingNo: "3",
                              //   valueLinearProgressIndicator: .07,
                              //   ratePrecentage: "7%",
                              // ),
                              // RatingAnalyzingRow(
                              //   ratingNo: "2",
                              //   valueLinearProgressIndicator: 0,
                              //   ratePrecentage: "0%",
                              // ),
                              // RatingAnalyzingRow(
                              //   ratingNo: state.product.,
                              //   valueLinearProgressIndicator: .02,
                              //   ratePrecentage: "2%",
                              // ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(Icons.star, color: ColorsHelper.amber),
                          Text(
                            "${state.product.reviewSummary.averageRating}",
                            style: Styles.textStyle14,
                          ),
                          Spacer(),
                          Text("05- oct 2020", style: Styles.textStyle14),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text("Erric Hoffman", style: Styles.textStyle14),
                      Text(
                        "Interdum et malesuada fames ac ante ipsum primis in faucibus. Morbi ut nisi odio. Nulla facilisi. Nunc risus massa, gravida id egestas ",
                        style: Styles.textStyle14.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      CustomElevatedButton(
                        buttonText: "GO To CART ",
                        onPressedFunction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartView()),
                          );
                        },
                      ),
                    ],
                  );
                }
                return Center(child: Text("No product found"));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateBrandRow({required String title, required String value}) {
    return Row(
      children: [
        Text(title, style: Styles.textStyle16),
        SizedBox(width: 10.w),
        Text(
          value,
          style: Styles.textStyle14.copyWith(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
