import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/widgets/list.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<Product> futureProduct;
  @override
  void initState() {
    super.initState();
    futureProduct = fetchProduct();
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: 100.0),
            child: Text(
              'Product Details',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Icon(
              Icons.share_rounded,
              color: Colors.black,
            ),
            AddingHeight(
              heightValue: 40.0,
            ),
          ],
        ),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: FutureBuilder<Product>(
                      future: futureProduct,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          String vectorUrl = snapshot.data!.image;
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.network(vectorUrl),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Text(
                                      snapshot.data!.product_name,
                                      style: kTextStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'BDT ' +
                                              snapshot.data!.product_price
                                                  .toString(),
                                          style: kPriceStyle,
                                        ),
                                        AddingHeight(
                                          heightValue: 20.0,
                                        ),
                                        Text(
                                          'BDT 2,0000,000',
                                          style: kDiscountPrice,
                                        ),
                                        SizedBox(
                                          width: 40.0,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffDD3935),
                                            border: Border.all(
                                                width: 8.0,
                                                color: Color(0xffDD3935)),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Text(
                                            '50% off',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: RatingBar.builder(
                                      glowColor: Colors.yellow,
                                      itemSize: 25.0,
                                      itemCount: 5,
                                      initialRating: 5,
                                      direction: Axis.horizontal,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      unratedColor: Colors.grey,
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, left: 4.0),
                                    child: Text('Rating: ' +
                                        snapshot.data!.product_review_avg
                                            .toString() +
                                        ' /5'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'Select Color',
                                      style: kTitleStyle,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ButtonBar(
                                        children: [
                                          ColorButtons(
                                            colorName: 'Black',
                                            primaryColor: Colors.black,
                                            sideColor: Colors.black,
                                          ),
                                          ColorButtons(
                                              colorName: 'Yellow',
                                              primaryColor: Colors.amber,
                                              sideColor: Colors.amber),
                                          ColorButtons(
                                              colorName: 'Red',
                                              primaryColor: Colors.red,
                                              sideColor: Colors.red),
                                          ColorButtons(
                                              colorName: 'Blue',
                                              primaryColor: Colors.blue,
                                              sideColor: Colors.blue),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        color: Color(0xffEEF3F9),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: Text(
                                                'Delivery Information',
                                                style: kTitleStyle,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.local_shipping,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 15.0,
                                                  ),
                                                  Flexible(
                                                    fit: FlexFit.loose,
                                                    child: Text(
                                                        'Sent From Dhaka and, will arrive in 7/10 working days'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: Text(
                                                'Payment Method(Supported)',
                                                style: kTitleStyle,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: Row(
                                                children: [
                                                  PaymentButtons(
                                                    iconName: Icons
                                                        .check_circle_outline,
                                                    iconColor: Colors.green,
                                                    textContent: 'Bkash',
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: PaymentButtons(
                                                      iconName: FontAwesomeIcons
                                                          .timesCircle,
                                                      iconColor: Colors.red,
                                                      textContent: 'Bkash',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Row(
                                                children: [
                                                  PaymentButtons(
                                                    iconName: Icons
                                                        .check_circle_outline,
                                                    iconColor: Colors.green,
                                                    textContent: 'Bkash',
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: PaymentButtons(
                                                      iconName: Icons
                                                          .check_circle_outline,
                                                      iconColor: Colors.green,
                                                      textContent: 'Bkash',
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: PaymentButtons(
                                                      iconName: Icons
                                                          .check_circle_outline,
                                                      iconColor: Colors.green,
                                                      textContent: 'Bkash',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Description',
                                                    style: kTitleStyle,
                                                  ),
                                                  Icon(Icons.keyboard_arrow_up),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: UnorderedList([
                                                "Soft touch jersey",
                                                "Lose Fabric",
                                                "High Sensitive",
                                                "Soft touch jersey",
                                                "Lose Fabric",
                                                "High Sensitive",
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Additional Information',
                                                    style: kTitleStyle,
                                                  ),
                                                  Icon(Icons.keyboard_arrow_up)
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: UnorderedList([
                                                "Size: L, M, S, XL",
                                                "Colors: Black, Blue. Red",
                                              ]),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        throw 'Problem';
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddingHeight extends StatelessWidget {
  final double heightValue;

  AddingHeight({required this.heightValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.0,
    );
  }
}

class PaymentButtons extends StatelessWidget {
  final IconData iconName;
  final String textContent;
  final Color iconColor;

  PaymentButtons(
      {required this.iconName,
      required this.textContent,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Icon(
          iconName,
          color: iconColor,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 5.0),
          child: Text(textContent),
        )
      ],
    );
  }
}

class ColorButtons extends StatelessWidget {
  final String colorName;
  final Color primaryColor;
  final Color sideColor;

  ColorButtons(
      {required this.colorName,
      required this.primaryColor,
      required this.sideColor});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Text(colorName),
      style: TextButton.styleFrom(
        primary: primaryColor,
        side: BorderSide(
          color: sideColor,
          width: 1.0,
        ),
      ),
    );
  }
}

class Product {
  final String image;
  final String product_name;
  final int product_price;
  final int product_review_avg;

  Product(
      {required this.image,
      required this.product_name,
      required this.product_price,
      required this.product_review_avg});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      image: json['image'],
      product_name: json['product_name'],
      product_price: json['product_price'],
      product_review_avg: json['product_review_avg'],
    );
  }
}

Future<Product> fetchProduct() async {
  final response = await http.get(Uri.parse(
      'http://3.1.180.10/api/product-core/suzuki-gsx-r150-fi-dual-channel-abs-yvj2/0/'));

  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load products');
  }
}

void ratingSystem(String text) {}
