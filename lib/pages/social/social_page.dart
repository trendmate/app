import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/providers/social_provider.dart';
import 'package:trendmate/providers/user_provider.dart';

class SocialPage extends StatelessWidget {
  static const routeName = '/social-page';
  const SocialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SocialProvider>(
      builder: (context, value, child) => UserProvider.instance.user == null
          ? Center(
              child: Text("You must be logged in"),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: value.prods
                  .map((e) => SocialProduct(
                        product: e,
                        provider: value,
                      ))
                  .toList(),
            ),
    );
  }
}

class SocialProduct extends StatelessWidget {
  const SocialProduct({
    Key? key,
    required this.product,
    required this.provider,
  }) : super(key: key);

  final Product product;
  final SocialProvider provider;

  void _share() async {
    await Share.share('check out this product ${product.url}');
    provider.incrementShare(product);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  product.fromUserName != null
                      ? Text(product.fromUserName ?? "")
                      : Text(product.fromBoardName ?? ""),
                  Spacer(),
                  Icon(
                    Icons.ios_share,
                    size: 16,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(product.share_no.toString())
                ],
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        imageUrl: product.image,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                  onTap: () {
                    _share();
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                      child: Row(
                        children: [
                          Text("Share"),
                          Spacer(),
                          Icon(
                            Icons.ios_share,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
