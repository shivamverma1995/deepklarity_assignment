import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'database_handler.dart';
import 'model/productListModel.dart';

class SecondPage extends StatefulWidget {
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    getProductsFromDB().then((value) {
      products = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Loading...'),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int i) {
                return Card(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: products[i].productURL,
                            height: 100,
                            width: 150,
                            fit: BoxFit.fill,
                            placeholder: (BuildContext context, String text) {
                              return Image.asset('assets/loading.gif');
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    products[i].productName,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RatingBarIndicator(
                                      itemSize: 32,
                                      rating: products[i].productRating,
                                      unratedColor: Colors.amber[200],
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Icon(
                                          Icons.star,
                                          color: Colors.amber[600],
                                        );
                                      }),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 0,
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.only(left: 24),
                        title: Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        childrenPadding:
                            EdgeInsets.only(left: 24, right: 24, bottom: 16),
                        children: [
                          Text(
                            products[i].productDescription,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                ));
              }),
    );
  }
}
