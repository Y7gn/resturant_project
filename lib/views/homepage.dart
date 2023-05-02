import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resturant_project/views/searchView.dart';

import 'Favourite.dart';
import 'homeView.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  getUser() {}
  // List products = [];
  // List featured = [];
  // getData() async {
  //   CollectionReference productRef = FirebaseFirestore.instance.collection('products');

  // await productRef.where("featured",isEqualTo: true).get().then((value){
  //   value.docs.forEach((element){
  //     // print(element);
  //     // print("####################");
  //     setState(() {
  //       featured.add(element.data());
  //       featured.add(element.id);
  //     });
  //   });
  //   print(featured);
  // });

  // var responsebody = await productRef.get();
  // responsebody.docs.forEach((element) {
  //   setState(() {
  //     products.add(element.data());
  //   });
  //   print(products);
  // });

  // var snapshots = await productRef.get();
  // for (var doc in snapshots.docs) {
  //   await doc.reference.delete();
  // }

  // var db = FirebaseFirestore.instance;
  // final product = db.collection("products");
  // final data1 = <String, dynamic>{
  //   "description": "product1 Description",
  //   "price": 10,
  //   "title": "product1 Title",
  //   "urlImage": "https://res.cloudinary.com/l4ume/image/upload/v1678403195/burgersPhoto/burgerpotatoMainpage2_wsefpg.png",
  //   "featured":true,
  // };
  // product.doc().set(data1);

  // final data2 = <String, dynamic>{
  //   "description": "product2 Description",
  //   "price": 20,
  //   "title": "product2 Title",
  //   "urlImage": "https://res.cloudinary.com/l4ume/image/upload/v1678403231/burgersPhoto/chickwnBurger-removebg-preview_kte8ms.png",
  //   "featured":true,
  // };
  // product.doc().set(data2);

  // final data3 = <String, dynamic>{
  //   "description": "product3 Description",
  //   "price": 30,
  //   "title": "product3 Title",
  //   "urlImage": "https://res.cloudinary.com/l4ume/image/upload/v1678403231/burgersPhoto/chickwnBurger-removebg-preview_kte8ms.png",
  //   "featured":true,
  // };
  // product.doc().set(data3);
  // final data4 = <String, dynamic>{
  //   "description": "product4 Description",
  //   "price": 40,
  //   "title": "product4 Title",
  //   "urlImage": "",
  //   "featured":false,
  // };
  // product.doc().set(data4);
  // }

  @override
  void initState() {
    getUser();
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const Center(child: homeView()),
      const Center(child: searchView()),
      const Center(child: MovieApp()),
      const Center(child: Text("Profile")),
    ];

    return Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),

        // appBar: AppBar(
        //     backgroundColor: Colors.white,
        //     title: const Text("Main UI"),
        //     actions: [
        //       PopupMenuButton<MenuAction>(
        //         onSelected: (value) async {
        //           switch (value) {
        //             case MenuAction.logout:
        //               final shouldLogout = await showLogOutDialog(context);
        //               devtools.log(value.toString());
        //               if (shouldLogout) {
        //                 await FirebaseAuth.instance.signOut();
        //                 Navigator.of(context)
        //                     .nNamedAndRemoveUntil('/login/', (_) => false);
        //               }
        //               break;
        //           }
        //         },
        //         itemBuilder: (context) {
        //           return const [
        //             const PopupMenuItem<MenuAction>(
        //               value: MenuAction.logout,
        //               child: Text('Log out'),
        //             )
        //           ];
        //         },
        //       )
        //     ],
        //   ),

        body: SafeArea(

            // child: Column(
            //   children: [
            //     Padding(
            //     padding: const EdgeInsets.all(20),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Image.asset("assets/images/bars.png", width: 20, height: 20),
            //         Image.asset("assets/images/user.png", width: 20, height: 20),
            //       ],
            //       ),
            //     ),
            child: tabs[_currentIndex]
            //   ],
            // ),

            ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          // type: BottomNavigationBarType.fixed,

          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                // backgroundColor:Colors.red,
                backgroundColor: Colors.white,
                label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.star,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                label: 'home'),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        )
        //  SafeArea(
        // child: Container(
        //   padding: const EdgeInsets.all(14),
        //   // margin: EdgeInsets.symmetric(horizontal: 24),
        //   decoration: BoxDecoration(
        //     color: Colors.black,
        //     // borderRadius: BorderRadius.all(Radius.circular(24)),
        //     borderRadius: BorderRadius.only(
        //         // topRight: Radius.circular(24),
        //         // topLeft: Radius.circular(24),
        //         ),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.withOpacity(0.5),
        //         spreadRadius: 5,
        //         blurRadius: 7,
        //         offset: Offset(0, 3), // changes position of shadow
        //       ),
        //     ],
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       GestureDetector(
        //         onTap: () {
        //           devtools.log("message");
        //         },
        //         child: SizedBox(
        //             height: 36,
        //             width: 36,
        //             child: rive.RiveAnimation.asset(
        //               "assets/RiveAssets/icons.riv",
        //               artboard: 'HOME',
        //               // color:Colors.white,
        //             )),
        //       ),
        //       GestureDetector(
        //         onTap: () {
        //           devtools.log("message");
        //         },
        //         child: SizedBox(
        //             height: 36,
        //             width: 36,
        //             child: rive.RiveAnimation.asset(
        //               "assets/RiveAssets/icons.riv",
        //               artboard: 'LIKE/STAR',
        //             )),
        //       ),
        //       GestureDetector(
        //         onTap: () {
        //           devtools.log("message");
        //         },
        //         child: SizedBox(
        //           height: 36,
        //           width: 36,
        //           child: Image.asset(
        //             'assets/images/shoppingCart.png',
        //             width: 36,
        //             height: 36,
        //           ),
        //         ),
        //       ),
        //       GestureDetector(
        //         onTap: () {
        //           devtools.log("message");
        //         },
        //         child: SizedBox(
        //             height: 36,
        //             width: 36,
        //             child: rive.RiveAnimation.asset(
        //               "assets/RiveAssets/icons.riv",
        //               artboard: 'USER',
        //             )),
        //       )
        //     ],
        //   ),
        // ),
        // )
        );
  }
}
