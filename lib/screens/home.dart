import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommarce_project/appColors/colors.dart';
import 'package:ecommarce_project/screens/Cart.dart';
import 'package:ecommarce_project/screens/product_details.dart';
import 'package:ecommarce_project/widgets/custom_Button.dart';
import 'package:ecommarce_project/widgets/custom_Chips.dart';
import 'package:ecommarce_project/widgets/custom_Header_Text.dart';
import 'package:ecommarce_project/widgets/custom_inputField.dart';
import 'package:ecommarce_project/widgets/custom_medium_text.dart';
import 'package:ecommarce_project/widgets/custom_small_text.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: CustomHeaderText(text: "Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
            },
            icon: Icon(
              Icons.shopping_cart,
              size: 35,
              color: AppColors.textWhite,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CustomInputfield(
                  value: "Search",
                  icon: Icons.search,
                  controller: _searchController,
                  validator: (v) {
                    return null;
                  },
                ),
                SizedBox(height: 25),
                CustomHeaderText(text: "Categories"),
                SizedBox(height: 15),
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    CustomChip(type: "Electric"),
                    CustomChip(type: "Sports Car"),
                    CustomChip(type: "Sedan"),
                    CustomChip(type: "Truck"),
                    CustomChip(type: "Hybrid"),
                  ],
                ),
                SizedBox(height: 20),
                CustomHeaderText(text: "Best Selling"),
                SizedBox(height: 20),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: CustomMediumText(text: "No Available Products"),
                      );
                    }

                    final products = snapshot.data!.docs;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.5,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product =
                            products[index].data() as Map<String, dynamic>;
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.inputField,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              product['images'] != null &&
                                      product['images'].isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        product['images'][0],
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: AppColors.textGray,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.image,
                                          color: AppColors.textWhite,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: CustomSmallText(
                                  text: product['brand'] ?? '',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: CustomSmallText(
                                  text: product['model'] ?? '',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),

                                child: CustomSmallText(
                                  text: " ${product['year'].toString()}",
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: CustomSmallText(
                                  text: "\$${product['price'].toString()}",
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: CustomButton(
                                  text: "details",
                                  borderRadius: 12,
                                  height: 40,
                                  width: double.infinity,
                                  backgroundColor: AppColors.primary,
                                  icon: Icons.details,
                                  iconColor: AppColors.textWhite,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                          imageUrl:
                                              product['images'] != null &&
                                                  product['images'].isNotEmpty
                                              ? product['images'][0]
                                              : '',
                                          brand: product['brand'] ?? '',
                                          model: product['model'] ?? '',
                                          year: product['year'] is int
                                              ? product['year']
                                              : int.tryParse(
                                                      product['year']
                                                          .toString(),
                                                    ) ??
                                                    0,
                                          price: product['price'] is double
                                              ? product['price']
                                              : double.tryParse(
                                                      product['price']
                                                          .toString(),
                                                    ) ??
                                                    0.0,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
