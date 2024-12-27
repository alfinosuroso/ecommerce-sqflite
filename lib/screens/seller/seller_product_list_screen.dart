import 'package:ecommerce_sqflite/common/app_colors.dart';
import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/widgets/custom_text_field.dart';
import 'package:ecommerce_sqflite/widgets/line_spacing.dart';
import 'package:ecommerce_sqflite/widgets/primary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SellerProductListScreen extends StatefulWidget {
  const SellerProductListScreen({super.key});

  @override
  State<SellerProductListScreen> createState() =>
      _SellerProductListScreenState();
}

class _SellerProductListScreenState extends State<SellerProductListScreen> {
  String _selectedSortingOption = 'A-Z';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFab(context),
    );
  }

  FloatingActionButton _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.go("/product-seller/add");
      },
      child: const Icon(Icons.add),
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
            child: _productGrid(context),
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

  Widget _productGrid(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return _productItem(context, index);
      },
    );
  }

  Widget _productItem(
    BuildContext context,
    int index,
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
          Dimen.verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ElevatedButton(onPressed: () {}, child: Text("Edit"))),
              Dimen.horizontalSpaceMedium,
              PrimaryTextButton(
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: AppColors.darkRed),
                onPressed: () {},
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
          onPressed: () {},
          icon: const Icon(Icons.add),
        )
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
