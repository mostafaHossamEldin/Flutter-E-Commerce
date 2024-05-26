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

class UserCart extends HookWidget {
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
                    "Cart Products",
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
                              .getProducts(userProvider.user.cart.keys.toList())
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
                            ])
                          : [
                              ...productProvider
                                  .getProducts(
                                      userProvider.user.cart.keys.toList())
                                  .map(
                                    (product) => ProductWideCard(
                                      product: product,
                                      canSetQuantity: true,
                                      isVendor: false,
                                      deleteProduct: () {
                                        userProvider.user.cart
                                            .remove(product.id);
                                      },
                                      editProduct: () {
                                        context.push("/product/" +
                                            product.id.toString());
                                      },
                                    ),
                                  )
                                  .toList(),
                              SizedBox(
                                height: 20,
                              ),
                            ]),
                ),
                Container(
                  width: 335,
                  height: 52,
                  padding: const EdgeInsets.only(right: 5),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFF26356E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 155,
                        height: 52,
                        child: Text(
                          // 'Total: \$${productProvider.getProducts(userProvider.user.cart.keys.toList()).reduce((product, intVal) => intVal + product.price * (1 - product.discountPercentage) * userProvider.user.cart)}',
                          'Total: \$${productProvider.getProducts(userProvider.user.cart.keys.toList()).fold(0.0, (intVal, product) => intVal + product.price * ((100 - product.discountPercentage) / 100) * userProvider.user.cart[product.id]!)}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Istok Web',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        width: 160,
                        height: 42,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            context.push('/payment');
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            'Checkout',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF26356E),
                              fontSize: 20,
                              fontFamily: 'Istok Web',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
