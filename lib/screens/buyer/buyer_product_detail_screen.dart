import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/widgets/line_spacing.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuyerProductDetailScreen extends StatefulWidget {
  const BuyerProductDetailScreen({super.key});

  @override
  State<BuyerProductDetailScreen> createState() =>
      _BuyerProductDetailScreenState();
}

class _BuyerProductDetailScreenState extends State<BuyerProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(Dimen.mediumRadius),
                      bottomRight: Radius.circular(Dimen.mediumRadius)),
                  child: Image.asset(
                    "assets/images/sample-1.jpeg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 40.h,
                  ),
                ),
                Padding(
                  padding: Dimen.defaultPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Product Name Long Long ",
                          style: Theme.of(context).textTheme.titleLarge),
                      Dimen.verticalSpaceSmall,
                      Chip(label: Text("Tersedia: 100")),
                      Dimen.verticalSpaceSmall,
                      const LineSpacing(),
                      Dimen.verticalSpaceSmall,
                      Text(
                          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.")
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () {}, child: Text("Tambahkan ke Kerangjang")))
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Detail Produk"),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_checkout),
        )
      ],
    );
  }
}
