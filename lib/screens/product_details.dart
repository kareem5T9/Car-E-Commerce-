import 'package:ecommarce_project/appColors/colors.dart';
import 'package:ecommarce_project/layout/Custom_Navigation_bar.dart';
import 'package:ecommarce_project/services/firestore_services.dart';
import 'package:ecommarce_project/widgets/custom_Button.dart';
import 'package:ecommarce_project/widgets/custom_medium_text.dart';
import 'package:ecommarce_project/widgets/custom_small_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductDetails extends StatelessWidget {
  String imageUrl;
  String brand;
  String model;
  int year;
  double price;

  ProductDetails({
    required this.imageUrl,
    required this.brand,
    required this.model,
    required this.year,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CustomNavigationBar()),
            );
          },
          icon: Icon(Icons.arrow_back, color: AppColors.textWhite),
        ),
        centerTitle: true,
        title: CustomMediumText(text: "Product Details"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30),
            CustomMediumText(text: "Brand: $brand"),
            SizedBox(height: 30),
            CustomMediumText(text: "Model: $model"),
            SizedBox(height: 30),
            CustomMediumText(text: "Year: $year"),
            SizedBox(height: 30),
            CustomMediumText(text: "Price: \$$price"),
            SizedBox(height: 90),

            CustomButton(
              text: "Add to Cart",
              borderRadius: 12,
              height: 50,
              width: double.infinity,
              backgroundColor: AppColors.primary,
              icon: Icons.shopping_cart,
              iconColor: AppColors.textWhite,
              onPressed: () async {
                await addToCart(
                  brand: brand,
                  model: model,
                  price: price,
                  imageUrls: [imageUrl],
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: CustomSmallText(
                      text: "$brand $model added to cart",
                    ),

                    backgroundColor: AppColors.inputField,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
