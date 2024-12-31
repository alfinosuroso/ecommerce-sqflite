import 'package:ecommerce_sqflite/bloc/product/product_bloc.dart';
import 'package:ecommerce_sqflite/bloc/user/user_bloc.dart';
import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:ecommerce_sqflite/models/product_detail.dart';
import 'package:ecommerce_sqflite/models/user.dart';
import 'package:ecommerce_sqflite/services/dao/product_dao.dart';
import 'package:ecommerce_sqflite/services/session/auth_service.dart';
import 'package:ecommerce_sqflite/widgets/custom_text_field.dart';
import 'package:ecommerce_sqflite/widgets/line_spacing.dart';
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
  List<ProductDetail> products = [];
  final User? _user = AuthService.getUser();
  String _selectedSortingOption = 'A-Z';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(ProductDao())..add(GetProducts()),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return _buildBody(context);
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: Dimen.defaultPadding,
      child: Column(
        children: [
          _searchBar(),
          _filterSortingButton(),
          Dimen.verticalSpaceMedium,
          Expanded(
            child: _productGrid(),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return const CustomTextFormField(
      title: null,
      hintText: "Cari nama produk...",
      prefix: Icon(
        Icons.search,
        color: Colors.grey,
      ),
    );
  }

  Widget _filterSortingButton() {
    return OutlinedButton(
      onPressed: () {
        _showFilterSortingSheet(context);
      },
      child: const Text("Filter & Sorting"),
    );
  }

  Widget _productGrid() {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return _productItem(index: index);
      },
    );
  }

  Widget _productItem({
    required int index,
  }) {
    return InkWell(
      onTap: () {
        context.go("/product-buyer/details");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimen.radius),
              child: Image.asset(
                "assets/images/sample-1.jpeg",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Dimen.verticalSpaceSmall,
          Text(
            "Product Name LongLongLongLong",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Rp. 50000",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppThemeData.getTheme(context).primaryColor,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
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
          },
          icon: const Icon(Icons.logout, color: AppColors.red),
        ),
      ],
    );
  }

  void _showFilterSortingSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimen.radius)),
      ),
      builder: (context) {
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
                          onPressed: () {}, child: const Text("Reset"))),
                  Dimen.horizontalSpaceMedium,
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("Terapkan")))
                ],
              ),
            ],
          ),
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
                setState(() {
                  _selectedSortingOption = newValue!;
                });
              },
            ),
          ],
        ));
  }
}
