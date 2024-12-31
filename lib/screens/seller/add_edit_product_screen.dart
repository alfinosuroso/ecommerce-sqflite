import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ecommerce_sqflite/bloc/product/product_bloc.dart';
import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:ecommerce_sqflite/models/product.dart';
import 'package:ecommerce_sqflite/models/user.dart';
import 'package:ecommerce_sqflite/services/session/auth_service.dart';
import 'package:ecommerce_sqflite/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';

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
  User? user = AuthService.getUser();
  final _formAddKey = GlobalKey<FormState>();

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
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (Platform.isAndroid) {
      if (await _handleAndroidPermissions()) {
        _setPickImage();
      } else {
        print("Permission denied. Please enable storage/media permissions.");
      }
    }
  }

  Future<bool> _handleAndroidPermissions() async {
    // Check if the SDK version is greater than or equal to 34
    if (Platform.isAndroid && (await _androidSDKVersion()) >= 34) {
      PermissionStatus permissionStatus =
          await Permission.mediaLibrary.request();

      if (permissionStatus.isGranted) {
        return true;
      }
    }

    if (Platform.isAndroid && (await _androidSDKVersion()) >= 33) {
      PermissionStatus permissionStatus = await Permission.photos.request();

      if (permissionStatus.isGranted) {
        return true;
      }
    }

    PermissionStatus permissionStatusStorage =
        await Permission.storage.request();
    return permissionStatusStorage.isGranted;
  }

  Future<int> _androidSDKVersion() async {
    final version = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
    return version;
  }

  _setPickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: Dimen.defaultPadding,
      child: Form(
        key: _formAddKey,
        child: Column(
          children: [
            _formBody(),
            ElevatedButton(
              onPressed: () {
                if (_image.isEmpty) {
                  SharedCode(context).errorSnackBar(
                      text: "Silahkan pilih gambar terlebih dahulu");
                } else if (_formAddKey.currentState!.validate()) {
                  context.read<ProductBloc>().add(AddProduct(Product(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        stock: int.parse(_stockController.text),
                        price: int.parse(_priceController.text),
                        image: _image,
                        userId: user!.id!,
                      )));
                  debugPrint("berhasil menambahkan data");
                  SharedCode(context)
                      .successSnackBar(text: "Berhasil tambah data");
                  context.pop(true);
                } else {
                  SharedCode(context)
                      .errorSnackBar(text: "Gagal menambahkan data");
                }
              },
              child: Text(
                  widget.product == null ? "Tambah Produk" : "Edit Produk"),
            ),
          ],
        ),
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
              onTap: _pickImage,
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
                      : Image.file(File(_image), fit: BoxFit.cover),
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
              keyboardType: TextInputType.number,
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
