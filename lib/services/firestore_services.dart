import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addProduct({
  required String brand,
  required String model,
  required String year,
  required String price,
  required String description,
  required List<String> imageUrls,
}) async {
  await FirebaseFirestore.instance.collection("products").add({
    "brand": brand,
    "model": model,
    "year": year,
    "price": double.tryParse(price) ?? 0,
    "description": description,
    "images": imageUrls,
    "createdAt": FieldValue.serverTimestamp(),
  });
}

Future<void> addToCart({
  required String brand,
  required String model,
  required double price,
  required List<String> imageUrls,
}) async {
  await FirebaseFirestore.instance.collection("Cart").add({
    "brand": brand,
    "model": model,
    "price": price,
    "images": imageUrls,
    "createdAt": FieldValue.serverTimestamp(),
  });
}
