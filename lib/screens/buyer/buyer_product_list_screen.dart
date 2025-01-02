import 'package:ecommerce_sqflite/bloc/product/product_bloc.dart';
import 'package:ecommerce_sqflite/bloc/user/user_bloc.dart';
import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/common/product_utils.dart';
import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:ecommerce_sqflite/models/product_detail.dart';
import 'package:ecommerce_sqflite/models/user.dart';
import 'package:ecommerce_sqflite/services/dao/product_dao.dart';
import 'package:ecommerce_sqflite/services/session/auth_service.dart';
import 'package:ecommerce_sqflite/widgets/custom_text_field.dart';
import 'package:ecommerce_sqflite/widgets/line_spacing.dart';
import 'package:ecommerce_sqflite/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BuyerProductListScreen extends StatefulWidget {
  const BuyerProductListScreen({super.key});

  @override
  State<BuyerProductListScreen> createState() => _BuyerProductListScreenState();
}

class _BuyerProductListScreenState extends State<BuyerProductListScreen> {
  List<ProductDetail> _products = [];
  final User? _user = AuthService.getUser();
  String _selectedSortingOption = '';
  final ValueNotifier<bool> _triggerProduct = ValueNotifier(true);
  final ValueNotifier<bool> _triggerFilter = ValueNotifier(true);
  final TextEditingController _searchController = TextEditingController();

  // init
  @override
  void initState() {
    debugPrint('init');
    super.initState();
  }

  // dispose
  @override
  void dispose() {
    super.dispose();
    _triggerProduct.dispose();
    _triggerFilter.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(ProductDao())..add(GetProducts()),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductLoaded) {
              debugPrint('build loaded');

              _products.clear();
              _products.addAll(state.products);

              if (_searchController.text.isNotEmpty) {
                _products = ProductUtils(context).searchProducts(
                    query: _searchController.text,
                    newProducts: _products,
                    oldProducts: state.products);
                _triggerProduct.value = !_triggerProduct.value;
              }
              _products = ProductUtils(context).filterProducts(
                query: _selectedSortingOption,
                products: _products,
              );
              _triggerProduct.value = !_triggerProduct.value;

              return _buildBody(context, state.products);
            }
            return const Text("Terjadi Kesalahan Pada Database");
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<ProductDetail> productList) {
    return Padding(
      padding: Dimen.defaultPadding,
      child: Column(
        children: [
          _searchBar(productList),
          _filterSortingButton(context, productList),
          Dimen.verticalSpaceMedium,
          ValueListenableBuilder(
            valueListenable: _triggerProduct,
            builder: (context, __, ___) {
              debugPrint("trigger");
              debugPrint("product: $_products");
              return Expanded(child: _productGrid(context));
            },
          ),
        ],
      ),
    );
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
        _products = ProductUtils(context).searchProducts(
          query: _searchController.text,
          newProducts: _products,
          oldProducts: productList,
        );
        _triggerProduct.value = !_triggerProduct.value;
        return null;
      },
    );
  }

  Widget _filterSortingButton(
      BuildContext context, List<ProductDetail> productList) {
    return OutlinedButton(
      onPressed: () {
        _showFilterSortingSheet(context, productList);
      },
      child: const Text("Filter & Sorting"),
    );
  }

  Widget _productGrid(BuildContext context) {
    return _products.isEmpty
        ? const Center(child: Text("Produk tidak ditemukan"))
        : RefreshIndicator(
            onRefresh: () async {
              context.read<ProductBloc>().add(GetProducts());
            },
            child: GridView.builder(
              itemCount: _products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                ProductDetail productDetail = _products[index];
                return ProductItem(
                  context: context,
                  index: index,
                  productDetail: productDetail,
                  user: _user,
                );
              },
            ),
          );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Belanja"),
      actions: [
        IconButton(
          onPressed: () {
            context.go("/product-buyer/cart");
          },
          icon: const FaIcon(FontAwesomeIcons.cartShopping),
        ),
        IconButton(
          onPressed: () async {
            await AuthService.clearUser();
            SharedCode(context).successSnackBar(text: "Berhasil logout");
            context.read<UserBloc>().add(CheckUser());
            context.go("/signin");
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
                        borderRadius: BorderRadius.circular(Dimen.mediumRadius),
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
                  _buildSortingOption(context, 'Price (High-Low)', 'High-Low'),
                  _buildSortingOption(context, 'Price (Low-High)', 'Low-High'),
                  Dimen.verticalSpaceMedium,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _selectedSortingOption = "";
                            _products = ProductUtils(context).filterProducts(
                              query: _selectedSortingOption,
                              products: productList,
                            );
                            _triggerFilter.value = !_triggerFilter.value;
                            _triggerProduct.value = !_triggerProduct.value;
                            Navigator.pop(context);
                          },
                          child: const Text("Reset"),
                        ),
                      ),
                      Dimen.horizontalSpaceMedium,
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _products = ProductUtils(context).filterProducts(
                              query: _selectedSortingOption,
                              products: _products,
                            );
                            _triggerProduct.value = !_triggerProduct.value;
                            Navigator.pop(context);
                          },
                          child: const Text("Terapkan"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

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
      ),
    );
  }
}
