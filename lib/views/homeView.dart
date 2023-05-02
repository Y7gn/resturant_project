import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';

import 'dart:developer' as devtools show log;

import '../utils/unUsedComponent.dart';

class homeView extends StatefulWidget {
  const homeView({super.key});

  @override
  State<homeView> createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  List featured = [];
  var featurds;
  getFeaturedContent() async {
    CollectionReference productRef =
        FirebaseFirestore.instance.collection('products');
    await productRef.where("featured", isEqualTo: true).get().then((value) {
      value.docs.forEach(
        (element) {
          // print(element.data());
          // print("####################");
          setState(() {
            featured.add(element.data());
          });
        },

        // var newMap = { ...featured, "id": element.id },
      );

      for (var i = 0; i < featured.length; i++) {
        featurds = featured.toList();
        featurds[i]["id"] = value.docs[i].id;
        // devtools.log(featurds.toString());
      }
    });
    // print(featurds);
  }

  @override
  void initState() {
    getFeaturedContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final urlImages = [
      'assets/images/burgerpotatoMainpage2.jpg',
      'assets/images/chickwnBurger-removebg-preview.png',
      'assets/images/chickwnBurger-removebg-preview.png',
    ];

    final titles = [
      "Zingen Burger",
      "Chicken Burger",
      "Flexer Burger",
    ];

    final prices = [
      12,
      23,
      24,
    ];
    final paddings = [
      20.0,
      0.0,
      0.0,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // title: Text('hi mohammed'),
        leading: const Icon(Icons.list, color: Colors.black),
        actions: [
          Theme(
              data: Theme.of(context).copyWith(
                cardColor: Colors.white,
              ),
              child: PopupMenuButton<MenuAction>(
                // color: Colors.black,
                onSelected: (value) async {
                  switch (value) {
                    case MenuAction.logout:
                      final shouldLogout = await showLogOutDialog(context);
                      // devtools.log(value.toString());
                      if (shouldLogout) {
                        await FirebaseAuth.instance.signOut();
                        context.pushReplacement("/login");
                      }
                      break;
                  }
                },
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem<MenuAction>(
                      value: MenuAction.logout,
                      child: Text('Log out'),
                    )
                  ];
                },
              )),
        ],
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ElevatedButton(
          //   onPressed: () => context.go('/details'),
          //   child: const Text('Go to the Details screen'),
          // ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Choose the",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.left,
                ),
                const Text("Food You Love",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    textAlign: TextAlign.left),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              // backgroundColor: Colors.white10,
              width: 350,
              height: 45,
              padding: const EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              // color: Col,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(30, 0, 0, 0),
                    spreadRadius: 0.01,
                    blurRadius: 9,
                    offset: const Offset(0, 3), // changes position of shadow
                  )
                ],
              ),
              child: const Text("Search for a food Item",
                  style: TextStyle(color: Colors.black26),
                  textAlign: TextAlign.start),
            ),
          ),
          // const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          // const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  const OutlinedCardExample(
                      categoryImg: "assets/images/burgersmainpage.png",
                      categoryTitle: "Burger"),
                  const OutlinedCardExample(
                      categoryImg: "assets/images/pizza-sliceMainPage.png",
                      categoryTitle: "Pizza"),
                  const OutlinedCardExample(
                      categoryImg: "assets/images/chicken.png",
                      categoryTitle: "Chicken"),
                ],
              ),
            ),
          ),
          // const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Burgers",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),

          const SizedBox(height: 20),
          SizedBox(
            // height: 220,
            child: CarouselSlider.builder(
              itemCount: featured.length,
              itemBuilder: (context, index, realIndex) {
                final id = featurds[index]['id'];
                final urlImage = featurds[index]['urlImage'];
                final title = featurds[index]['title'];
                final price = featurds[index]['price'];
                final padding = paddings[index];

                return buildImage(
                    urlImage, title, price, padding, index, id, context);
              },
              options: CarouselOptions(
                enlargeCenterPage: true,
                height: 220,
                viewportFraction: 0.50,
                enableInfiniteScroll: false,
                initialPage: 0,
                padEnds: false,
                enlargeFactor: 0.2,
                // autoPlay: true,
              ),
            ),
          ),
        ],
      )),
    );
  }
}

Widget buildImage(String urlImage, String title, int price, double padding,
        int index, String id, BuildContext context) =>
    GestureDetector(
      onTap: () {
        // context.pushNamed("product", params: {'id1': "dsadklaskld"});
        // context.pushNamed("product", params: {'id1': "id"});
        context.push("/product/$id");
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Container(
            // color: hexStringToColor(cardColor),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromARGB(255, 255, 0, 54),
                  Color.fromARGB(200, 255, 0, 54),
                ],
              ),
              boxShadow: [
                const BoxShadow(
                  color: Color.fromARGB(60, 0, 7, 165),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),

            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: DropShadow(
                        blurRadius: 4.0,
                        borderRadius: 40,
                        offset: const Offset(0, 3),
                        color: Color.fromARGB(161, 49, 49, 49),
                        spread: 1,
                        child: Image.network(urlImage, width: 150),
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        // color: hexStringToColor(fontColor),
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber[300],
                          size: 14,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber[300],
                          size: 14,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber[300],
                          size: 14,
                        ),
                        Icon(
                          Icons.star_border_outlined,
                          color: Colors.amber[300],
                          size: 14,
                        ),
                        Icon(
                          Icons.star_border_outlined,
                          color: Colors.amber[300],
                          size: 14,
                        ),
                      ],
                    ),
                    Text("\$$price",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          // color: hexStringToColor(fontColor)
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );

enum MenuAction { logout }

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancle")),
          TextButton(
              onPressed: () {
                // context.canPop();
                // print(context.canPop());
                // context.pushReplacement("/login");
                context.pop(true);
              },
              child: const Text("Log out"))
        ],
      );
    },
  ).then((value) => value ?? false);
}
