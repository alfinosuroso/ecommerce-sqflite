import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/models/product.dart';
import 'package:ecommerce_sqflite/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class AddEditProductScreen extends StatefulWidget {
  Product? product;
  AddEditProductScreen({this.product, super.key});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  // String _image = "assets/images/sample-1.jpeg";
  String _image = "";

  @override
  void initState() {
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.description;
      _stockController.text = widget.product!.stock.toString();
      _priceController.text = widget.product!.price.toString();
      _image = widget.product!.image;
      
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: Dimen.defaultPadding,
      child: Column(
        children: [
          _formBody(),
          ElevatedButton(
            onPressed: () {},
            child:
                Text(widget.product == null ? "Tambah Produk" : "Edit Produk"),
          ),
        ],
      ),
    );
  }

  Widget _formBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimen.radius),
                child: Container(
                  height: 20.h,
                  width: double.infinity,
                  color: AppColors.lightBlue,
                  child: _image.isEmpty
                      ? const Center(
                          child:
                              const FaIcon(FontAwesomeIcons.folder, size: 50))
                      : Image.asset(_image, fit: BoxFit.cover),
                ),
              ),
            ),
            Dimen.verticalSpaceMedium,
            CustomTextFormField(
              controller: _nameController,
              title: "Nama Produk",
            ),
            CustomTextFormField(
              controller: _descriptionController,
              title: "Deskripsi Produk",
              isMulti: true,
            ),
            CustomTextFormField(
              controller: _stockController,
              title: "Stok Produk",
            ),
            CustomTextFormField(
              controller: _priceController,
              title: "Harga",
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(widget.product == null ? "Tambah Produk" : "Edit Produk"),
    );
  }
}
