

import 'package:flutter/material.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/models/product_model.dart';
import 'package:flynetwork/src/interfaces/components/Animations/widget_animations.dart';
import 'package:flynetwork/src/interfaces/components/DropDowns/blockReport_dropdown.dart';
import 'package:flynetwork/src/interfaces/components/DropDowns/dropdown_menu.dart';

class ProductCard extends StatelessWidget {
  final VoidCallback? onRemove;
  final Product product;
  final bool? isOthersProduct;

  const ProductCard(
      {this.onRemove, required this.product, super.key, this.isOthersProduct});

  @override
  Widget build(BuildContext context) {
    return AnimatedEntrance(     duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 200),
      slideOffset: const Offset(0.0, 0.25),
      initialScale: 0.95,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
        child: Container(
          width: double.infinity,
          child: Stack(
            // Wrap the entire content in a Stack
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(product.image!),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                  ),
                  Container(
                    height: 80.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            product.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Text(
                                  '₹ ${product.price}',
                                  style: TextStyle(
                                    decoration: product.offerPrice != null
                                        ? TextDecoration.lineThrough
                                        : null,
                                    fontSize: 15.0,
                                    color:
                                        const Color.fromARGB(255, 112, 112, 112),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                if (product.offerPrice != null)
                                  Text(
                                    '₹ ${product.offerPrice}',
                                    style: const TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            'MOQ: ${product.moq}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (onRemove != null)
                Positioned(
                  top: 4.0,
                  right: 10.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropDownMenu(onRemove: onRemove!),
                    ),
                  ),
                ),
              if (isOthersProduct ?? false)
                Positioned(
                  top: 4.0,
                  right: 10.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: BlockReportDropdown(
                          product: product,
                          isBlocked: false,
                        )),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
