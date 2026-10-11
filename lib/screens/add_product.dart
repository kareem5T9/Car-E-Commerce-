import 'package:ecommarce_project/appColors/colors.dart';
import 'package:ecommarce_project/layout/Custom_Navigation_bar.dart';
import 'package:ecommarce_project/services/firestore_services.dart';
import 'package:ecommarce_project/services/image_services.dart';
import 'package:ecommarce_project/widgets/custom_Button.dart';
import 'package:ecommarce_project/widgets/custom_Header_Text.dart';
import 'package:ecommarce_project/widgets/custom_inputField.dart';
import 'package:ecommarce_project/widgets/custom_medium_text.dart';
import 'package:ecommarce_project/widgets/custom_small_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct();

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<PlatformFile> _images = [];

  final _formKey = GlobalKey<FormState>();

  TextEditingController _brandController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

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
          icon: Icon(Icons.arrow_back, size: 25, color: AppColors.textWhite),
        ),
        centerTitle: true,
        title: CustomMediumText(text: "Add Product"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 35),

                CustomInputfield(
                  value: "brand",
                  controller: _brandController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "الحقل فارغ يرجى ادخال قيمة";
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(height: 35),

                CustomInputfield(
                  value: "model",
                  controller: _modelController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "الحقل فارغ يرجى ادخال قيمة";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 35),
                CustomInputfield(
                  value: "year",
                  controller: _yearController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "الحقل فارغ يرجى ادخال قيمة";
                    } else if ((int.tryParse(v) == null)) {
                      return " أدخل سنة الاصدار بدون حروف أو رموز";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 35),
                CustomInputfield(
                  value: "price",
                  controller: _priceController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "الحقل فارغ يرجى ادخال قيمة";
                    } else if ((double.tryParse(v) == null)) {
                      return "أدخل سعر المنتج";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 35),

                CustomInputfield(
                  value: "description",

                  controller: _descriptionController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "الحقل فارغ يرجى ادخال قيمة";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 35),
                CustomHeaderText(text: "Upload Images"),

                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.textGray,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 35),
                      CustomHeaderText(text: "Add Images"),
                      CustomSmallText(text: "Upload image"),

                      CustomButton(
                        text: "upload",
                        backgroundColor: AppColors.textGray,
                        borderRadius: 50,
                        height: 40,
                        width: 200,
                        icon: Icons.photo,
                        iconColor: AppColors.textWhite,
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                allowMultiple: true,
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'png', 'jpeg'],
                                withData: true,
                              );
                          if (result != null) {
                            setState(() {
                              _images = result.files;
                            });
                          }
                        },
                      ),
                      _images.isNotEmpty
                          ? Wrap(
                              children: _images.map((img) {
                                return Image.memory(
                                  img.bytes!,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                );
                              }).toList(),
                            )
                          : CustomSmallText(text: "No images selected"),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                CustomButton(
                  text: "Add",
                  backgroundColor: AppColors.primary,
                  borderRadius: 50,
                  height: 60,
                  width: 400,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        List<String> imageUrls = [];
                        for (var img in _images) {
                          String? url = await uploadImageToImgBB(img);
                          if (url != null) imageUrls.add(url);
                        }
                        await addProduct(
                          brand: _brandController.text,
                          model: _modelController.text,
                          year: _yearController.text,
                          price: _priceController.text,
                          description: _descriptionController.text,
                          imageUrls: imageUrls,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: CustomMediumText(
                              text: "تم إضافة المنتج  بنجاح",
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );

                        setState(() {
                          _images.clear();
                          _brandController.clear();
                          _modelController.clear();
                          _yearController.clear();
                          _priceController.clear();
                          _descriptionController.clear();
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: CustomMediumText(
                              text: "حصل خطأ أثناء إضافة المنتج ",
                            ),

                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
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
