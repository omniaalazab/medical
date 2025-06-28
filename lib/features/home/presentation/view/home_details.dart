import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/models/product_model/product_model.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/colors.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/home/presentation/view/widget/category_item.dart';
import 'package:medical/features/home/presentation/view/widget/gridview_builder.dart';
import 'package:medical/core/models/product_model.dart';
import 'package:sizer/sizer.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({super.key});

  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  final List<ProductModel> productList = [
    ProductModel(
      id: 1,
      description: "",
      name: "",
      imageUrl: AssetsData.maskGroup,
      oldPrice: 100,
      newPrice: 80,
      isActive: true,
      // brand: Brand(id: 1, name: ""),
      category: Categories(id: 1, name: ""),
      expiryDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      createdAt: DateTime.now().toIso8601String(),
      productionDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      // unit: Unit(id: 1, name: "name", symbol: "symbol"),
      updatedAt: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      reviews: [],
      reviewSummary: ReviewSummary(
        averageRating: 4.2,
        totalReviews: 15,
        // ratings: Ratings(
        //   fiveStar: 4,
        //   fourStar: 5,
        //   threeStar: 5,
        //   twoStar: 5,
        //   oneStar: 4,
        // ),
      ),
      // ingredients: [
      //   Ingredient(id: 4, name: "name", description: "description"),
      // ],
    ),
    ProductModel(
      id: 2,
      description: "",
      name: "",
      imageUrl: AssetsData.maskGroup,
      oldPrice: 120,
      newPrice: 90,
      isActive: true,
      // brand: Brand(id: 1, name: ""),
      category: Categories(id: 1, name: ""),
      expiryDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      createdAt: DateTime.now().toIso8601String(),
      productionDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      // unit: Unit(id: 1, name: "name", symbol: "symbol"),
      updatedAt: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      reviews: [],
      reviewSummary: ReviewSummary(
        averageRating: 4.2,
        totalReviews: 15,
        // ratings: Ratings(
        //   fiveStar: 4,
        //   fourStar: 5,
        //   threeStar: 5,
        //   twoStar: 5,
        //   oneStar: 4,
        // ),
      ),
      // ingredients: [
      //   Ingredient(id: 4, name: "name", description: "description"),
      // ],
    ),
    ProductModel(
      id: 3,
      description: "",
      name: "",
      imageUrl: AssetsData.maskGroup,
      oldPrice: 120,
      newPrice: 90,
      isActive: true,
      // brand: Brand(id: 1, name: ""),
      category: Categories(id: 1, name: ""),
      expiryDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      createdAt: DateTime.now().toIso8601String(),
      productionDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      // unit: Unit(id: 1, name: "name", symbol: "symbol"),
      updatedAt: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      reviews: [],
      reviewSummary: ReviewSummary(
        averageRating: 4.2,
        totalReviews: 15,
        // ratings: Ratings(
        //   fiveStar: 4,
        //   fourStar: 5,
        //   threeStar: 5,
        //   twoStar: 5,
        //   oneStar: 4,
        // ),
      ),
      // ingredients: [
      //   Ingredient(id: 4, name: "name", description: "description"),
      // ],
    ),
    ProductModel(
      id: 1,
      description: "",
      name: "",
      imageUrl: AssetsData.maskGroup,
      oldPrice: 100,
      newPrice: 80,
      isActive: true,
      // brand: Brand(id: 1, name: ""),
      category: Categories(id: 1, name: ""),
      expiryDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      createdAt: DateTime.now().toIso8601String(),
      productionDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      // unit: Unit(id: 1, name: "name", symbol: "symbol"),
      updatedAt: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      reviews: [],
      reviewSummary: ReviewSummary(
        averageRating: 4.2,
        totalReviews: 15,
        // ratings: Ratings(
        //   fiveStar: 4,
        //   fourStar: 5,
        //   threeStar: 5,
        //   twoStar: 5,
        //   oneStar: 4,
        // ),
      ),
      // ingredients: [
      //   Ingredient(id: 4, name: "name", description: "description"),
      // ],
    ),
    ProductModel(
      id: 2,
      description: "",
      name: "",
      imageUrl: AssetsData.maskGroup,
      oldPrice: 120,
      newPrice: 90,
      isActive: true,
      // brand: Brand(id: 1, name: ""),
      category: Categories(id: 1, name: ""),
      expiryDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      createdAt: DateTime.now().toIso8601String(),
      productionDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      // unit: Unit(id: 1, name: "name", symbol: "symbol"),
      updatedAt: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      reviews: [],
      reviewSummary: ReviewSummary(
        averageRating: 4.2,
        totalReviews: 15,
        // ratings: Ratings(
        //   fiveStar: 4,
        //   fourStar: 5,
        //   threeStar: 5,
        //   twoStar: 5,
        //   oneStar: 4,
        // ),
      ),
      // ingredients: [
      //   Ingredient(id: 4, name: "name", description: "description"),
      // ],
    ),
    ProductModel(
      id: 3,
      description: "",
      name: "",
      imageUrl: AssetsData.maskGroup,
      oldPrice: 120,
      newPrice: 90,
      isActive: true,
      // brand: Brand(id: 1, name: ""),
      category: Categories(id: 1, name: ""),
      expiryDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      createdAt: DateTime.now().toIso8601String(),
      productionDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      // unit: Unit(id: 1, name: "name", symbol: "symbol"),
      updatedAt: DateTime.now().add(Duration(days: 365)).toIso8601String(),
      reviews: [],
      reviewSummary: ReviewSummary(
        averageRating: 4.2,
        totalReviews: 15,
        // ratings: Ratings(
        //   fiveStar: 4,
        //   fourStar: 5,
        //   threeStar: 5,
        //   twoStar: 5,
        //   oneStar: 4,
        // ),
      ),
      // ingredients: [
      //   Ingredient(id: 4, name: "name", description: "description"),
      // ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: ColorsHelper.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150?img=3',
                            ),
                          ),
                          const Spacer(),

                          SvgPicture.asset(
                            AssetsData.notifications,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          SvgPicture.asset(
                            AssetsData.shopping,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Hi, Rahul',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Welcome to Nilkanth Medical Store',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -30,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Medicine & Healthcare products',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Top Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CategoryItem(title: 'Dental', color: Colors.pinkAccent),
                      CategoryItem(
                        title: 'Wellness',
                        color: Colors.greenAccent,
                      ),
                      CategoryItem(title: 'Homeo', color: Colors.orangeAccent),
                      CategoryItem(title: 'Eye care', color: Colors.blueAccent),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Stack(
                    children: [
                      Image.asset(AssetsData.saveHome),
                      Positioned(
                        left: 4.h,
                        bottom: 0,
                        top: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Save extra on\n every order',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Etiam mollis metus\n non faucibus.',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ConstantText.dealsOfDay, style: Styles.textStyle16),
                      TextButton(
                        child: Text(
                          ConstantText.more,
                          style: Styles.textStyle14,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  // SizedBox(height: 5.h),
                  SizedBox(
                    height: 60.h,
                    child: GridViewBuilder(productList: productList),
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
