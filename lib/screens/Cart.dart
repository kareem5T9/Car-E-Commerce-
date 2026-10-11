import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommarce_project/appColors/colors.dart';
import 'package:ecommarce_project/layout/Custom_Navigation_bar.dart';
import 'package:ecommarce_project/widgets/custom_medium_text.dart';
import 'package:ecommarce_project/widgets/custom_small_text.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart();

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
        title: CustomMediumText(text: "Cart"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Cart')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: CustomMediumText(text: "Cart is empty"));
          }

          final cartItems = snapshot.data!.docs;
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final doc = cartItems[index];
              final data = doc.data() as Map<String, dynamic>;

              return Column(
                children: [
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        data['images'][0],
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),

                    title: Row(
                      children: [
                        CustomSmallText(text: data['brand']),

                        SizedBox(width: 5),
                        CustomSmallText(text: data['model']),
                      ],
                    ),
                    subtitle: CustomSmallText(text:data['price'].toString(),),
                    
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('Cart')
                            .doc(doc.id)
                            .delete();
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
