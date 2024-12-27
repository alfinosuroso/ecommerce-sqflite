import 'package:ecommerce_sqflite/common/app_theme_data.dart';
import 'package:ecommerce_sqflite/common/dimen.dart';
import 'package:ecommerce_sqflite/widgets/line_spacing.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';

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
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
  return Column(
      children: [
        Expanded(child: _topBody(context)),
        _bottomBody(context),
      ],
    );
  }

  Widget _bottomBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black87.withOpacity(0.4),
          spreadRadius: 10,
          blurRadius: 10,
          offset: const Offset(0, 10),
        ),
      ]),
      padding: Dimen.defaultPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Rp. 50000", 
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: AppThemeData.getTheme(context).primaryColor),
          ),
          Dimen.horizontalSpaceMedium,
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Tambahkan ke Keranjang"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBody(BuildContext context) {
    return SingleChildScrollView(
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
                const Text(
                    "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc. But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to"),
                Dimen.verticalSpaceSmall,
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Detail Produk"),
      actions: [
        IconButton(
          onPressed: () {
            context.go("/product-buyer/cart");
          },
          icon: const Icon(Icons.shopping_cart_checkout),
        )
      ],
    );
  }
}
