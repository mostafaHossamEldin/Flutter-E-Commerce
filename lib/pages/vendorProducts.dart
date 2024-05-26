import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:travelgear/Models/product.dart';
import '../providers/userProvider.dart';
import '../providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:travelgear/widgets/primaryButton.dart';
import '../widgets/addressDisplay.dart';
import '../widgets/customTextFields.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import '../Models/Address.dart';
import '../widgets/productWideCard.dart';

class VendorProducts extends HookWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ProductsProvider productProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Vendor Products",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                      children: (productProvider
                              .getVendorProducts(userProvider.user.uid)
                              .isEmpty)
                          ? ([
                              Text(
                                "No products found",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomPrimaryButton2(
                                  text: "Add Product",
                                  onPressed: () {
                                    context.push("/vendor-product");
                                  },
                                  width: double.infinity,
                                  height: 50,
                                  icon: Icon(
                                    size: 24,
                                    CupertinoIcons.add_circled_solid,
                                    color: Colors.white,
                                  )),
                            ])
                          : [
                              ...productProvider
                                  .getVendorProducts(userProvider.user.uid)
                                  .map(
                                    (product) => ProductWideCard(
                                      product: product,
                                      canSetQuantity: true,
                                      isVendor: true,
                                      deleteProduct: () {
                                        productProvider
                                            .deleteProduct(product.id);
                                      },
                                      editProduct: () {
                                        context.push("/vendor-product/" +
                                            product.id.toString());
                                      },
                                    ),
                                  )
                                  .toList(),
                              SizedBox(
                                height: 20,
                              ),
                              CustomPrimaryButton2(
                                  text: "Add Product",
                                  onPressed: () {
                                    context.push("/vendor-product");
                                  },
                                  width: double.infinity,
                                  height: 50,
                                  icon: Icon(
                                    size: 24,
                                    CupertinoIcons.add_circled_solid,
                                    color: Colors.white,
                                  )),
                            ]),
                )
              ],
            ),
          ),
        ));
  }
}
