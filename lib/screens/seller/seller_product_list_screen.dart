import 'dart:io';

import 'package:ecommerce_sqflite/bloc/product/product_bloc.dart';
import 'package:ecommerce_sqflite/bloc/user/user_bloc.dart';
import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/common/product_utils.dart';
import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:ecommerce_sqflite/models/product.dart';
import 'package:ecommerce_sqflite/models/product_detail.dart';
import 'package:ecommerce_sqflite/models/user.dart';
import 'package:ecommerce_sqflite/services/dao/product_dao.dart';
import 'package:ecommerce_sqflite/services/session/auth_service.dart';
import 'package:ecommerce_sqflite/widgets/custom_text_field.dart';
import 'package:ecommerce_sqflite/widgets/line_spacing.dart';
import 'package:ecommerce_sqflite/widgets/primary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SellerProductListScreen extends StatefulWidget {
  const SellerProductListScreen({super.key});

  @override
  State<SellerProductListScreen> createState() =>
      _SellerProductListScreenState();
}

class _SellerProductListScreenState extends State<SellerProductListScreen> {
  List<ProductDetail> products = [];
  final User? _user = AuthService.getUser();
  String _selectedSortingOption = 'A-Z';
  final ValueNotifier<bool> _triggerProduct = ValueNotifier(true);
  final ValueNotifier<bool> _triggerFilter = ValueNotifier(true);
  final TextEditingController _searchController = TextEditingController();

  //dispose all controller
  @override
  void dispose() {
    super.dispose();
    _triggerProduct.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductBloc(ProductDao())..add(GetProductsByUserId(_user!.id!)),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductSuccess) {
              SharedCode(context).successSnackBar(text: state.message);
            }
            if (state is ProductError) {
              SharedCode(context).errorSnackBar(text: state.message);
            }
          },
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductLoaded) {
              debugPrint('build loaded');

              products.clear();
              products.addAll(state.products);

              if (_searchController.text.isNotEmpty) {
                products = ProductUtils(context).searchProducts(
                    query: _searchController.text,
                    newProducts: products,
                    oldProducts: state.products);
                _triggerProduct.value = !_triggerProduct.value;
              } else if (_selectedSortingOption != "A-Z") {
                products = ProductUtils(context).filterProducts(
                    query: _selectedSortingOption,
                    newProducts: products,
                    oldProducts: state.products);
                _triggerProduct.value = !_triggerProduct.value;
              }

              return _buildBody(context, state.products);
            }
            return const Text("Terjadi Kesalahan Pada Database");
          },
        ),
        // floatingActionButton: _buildFab(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<ProductDetail> productList) {
    return Padding(
      padding: Dimen.defaultPadding,
      child: Column(
        children: [
          _searchBar(productList),
          _filterSortingButton(productList),
          Dimen.verticalSpaceMedium,
          ValueListenableBuilder(
            valueListenable: _triggerProduct,
            builder: (context, __, ___) {
              debugPrint("trigger");
              debugPrint("product: $products");
              return Expanded(child: _productGrid(context));
            },
          ),
          Dimen.verticalSpaceMedium,
          _addButton(context),
        ],
      ),
    );
  }

  Widget _addButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          final bool? isAdded = await context.push("/product-seller/add-edit");
          if (isAdded == true) {
            debugPrint("added");
            context.read<ProductBloc>().add(GetProductsByUserId(_user!.id!));
          } else {
            debugPrint("not added");
          }
        },
        child: const Text("Tambah data"));
  }

  Widget _searchBar(List<ProductDetail> productList) {
    return CustomTextFormField(
      title: null,
      hintText: "Cari nama produk...",
      prefix: const Icon(
        Icons.search,
        color: Colors.grey,
      ),
      controller: _searchController,
      onChanged: (value) {
        products = ProductUtils(context).searchProducts(
          query: _searchController.text,
          newProducts: products,
          oldProducts: productList,
        );
        _triggerProduct.value = !_triggerProduct.value;
        return null;
      },
    );
  }

  Widget _filterSortingButton(List<ProductDetail> productList) {
    return OutlinedButton(
      onPressed: () {
        _showFilterSortingSheet(context, productList);
      },
      child: const Text("Filter & Sorting"),
    );
  }

  Widget _productGrid(BuildContext context) {
    return products.isEmpty
        ? const Center(child: Text("Belum ada produk"))
        : GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              ProductDetail productDetail = products[index];
              return _productItem(
                context,
                index,
                productDetail,
              );
            },
          );
  }

  Widget _productItem(
    BuildContext context,
    int index,
    ProductDetail productDetail,
  ) {
    return InkWell(
      onTap: () {
        // context.go("/product-buyer/details");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimen.radius),
              child: Image.file(File(productDetail.product.image),
                  width: double.infinity, fit: BoxFit.cover),
            ),
          ),
          Dimen.verticalSpaceSmall,
          Text(
            productDetail.product.name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            SharedCode(context).formatToNumber(productDetail.product.price),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppThemeData.getTheme(context).primaryColor,
                ),
            overflow: TextOverflow.ellipsis,
          ),
          Dimen.verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        final bool? isEdited = await context.push(
                          "/product-seller/add-edit",
                          extra: Product(
                            id: productDetail.product.id,
                            name: productDetail.product.name,
                            description: productDetail.product.description,
                            image: productDetail.product.image,
                            price: productDetail.product.price,
                            stock: productDetail.product.stock,
                            userId: productDetail.user.id!,
                          ),
                        );
                        if (isEdited == true) {
                          debugPrint("edited");
                          context
                              .read<ProductBloc>()
                              .add(GetProductsByUserId(_user!.id!));
                        } else {
                          debugPrint("not edited");
                        }
                      },
                      child: const Text("Edit"))),
              Dimen.horizontalSpaceMedium,
              PrimaryTextButton(
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: AppColors.darkRed),
                onPressed: () {
                  context
                      .read<ProductBloc>()
                      .add(DeleteProduct(productDetail.product.id!));
                  context
                      .read<ProductBloc>()
                      .add(GetProductsByUserId(_user!.id!));
                },
                title: "Hapus",
              ),
            ],
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("List Produk"),
      actions: [
        IconButton(
          onPressed: () async {
            await AuthService.clearUser();
            SharedCode(context).successSnackBar(text: "Berhasil logout");
            context.read<UserBloc>().add(CheckUser());
          },
          icon: const Icon(Icons.logout, color: AppColors.red),
        ),
      ],
    );
  }

  void _showFilterSortingSheet(
      BuildContext context, List<ProductDetail> productList) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimen.radius)),
      ),
      builder: (context) {
        return ValueListenableBuilder(
            valueListenable: _triggerFilter,
            builder: (context, __, ___) {
              return Padding(
                padding: Dimen.defaultPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimen.mediumRadius),
                          child: Container(
                            width: 100,
                            height: 5,
                            color: Colors.grey[400],
                          )),
                    ),
                    Dimen.verticalSpaceLarge,
                    Text(
                      'Filter and Sorting',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Dimen.verticalSpaceMedium,
                    const LineSpacing(),
                    _buildSortingOption(context, 'Naming by A-Z', 'A-Z'),
                    _buildSortingOption(context, 'Naming by Z-A', 'Z-A'),
                    _buildSortingOption(
                        context, 'Price (High-Low)', 'High-Low'),
                    _buildSortingOption(
                        context, 'Price (Low-High)', 'Low-High'),
                    Dimen.verticalSpaceMedium,
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  _selectedSortingOption = "A-Z";
                                  products = ProductUtils(context)
                                      .filterProducts(
                                          query: _selectedSortingOption,
                                          newProducts: products,
                                          oldProducts: productList);
                                  _triggerFilter.value = !_triggerFilter.value;
                                  _triggerProduct.value =
                                      !_triggerProduct.value;
                                  Navigator.pop(context);
                                },
                                child: const Text("Reset"))),
                        Dimen.horizontalSpaceMedium,
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  products = ProductUtils(context)
                                      .filterProducts(
                                          query: _selectedSortingOption,
                                          newProducts: products,
                                          oldProducts: productList);
                                  _triggerProduct.value =
                                      !_triggerProduct.value;
                                  Navigator.pop(context);
                                },
                                child: const Text("Terapkan")))
                      ],
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

/*************  ✨ Codeium Command ⭐  *************/
  /// A widget that builds a sorting option
  ///
  /// The widget will render a radio list tile with the given title and value.
  /// The value of the radio list tile is stored in the _selectedSortingOption
  /// variable. When the value of the radio list tile is changed, the value of

/******  0f04243b-5a01-4778-9b8a-a99389c12b8c  *******/
  Widget _buildSortingOption(BuildContext context, String title, String value) {
    return Container(
        padding: Dimen.verticalPaddingSmall,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 2.0),
          ),
        ),
        child: Column(
          children: [
            RadioListTile<String>(
              title: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              value: value,
              groupValue: _selectedSortingOption,
              onChanged: (String? newValue) {
                _selectedSortingOption = newValue!;
                _triggerFilter.value = !_triggerFilter.value;
              },
            ),
          ],
        ));
  }
}
