import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resturant_project/providers/cart_provider.dart';
import 'package:resturant_project/views/DetailsView.dart';
import 'package:resturant_project/views/cartPage.dart';
import 'package:resturant_project/views/homepage.dart';
import 'package:resturant_project/views/searchView.dart';

import 'auth/login.dart';
import 'auth/signup.dart';
import 'firebase_options.dart';

bool? isLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  // var user = FirebaseAuth.instance.currentUser;

  String userId;
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    userId = user.uid.toString();
  }
  // if(user != null){
  isLogin = true;
  // }else{
  //   isLogin = false;
  // }
  // isLogin = user?.uid != null;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MyApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainPage();
      },
    ),
    // GoRoute(
    //   path: '/product/:id',
    //   name: 'product',
    //   builder: (context, state) => DetailsView(id: state.params['id']!),
    // ),
    // GoRoute(
    //   path: '/homepage',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const HomePage();
    //   },
    // ),
    // GoRoute(
    //   path: '/login',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const Login();
    //   },
    // ),
    // GoRoute(
    //   path: '/register',
    //   name: 'register',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const SignUp();
    //   },
    // ),
    // GoRoute(
    //   path: '/search',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const searchView();
    //   },
    // ),
    // GoRoute(
    //   path: '/cart',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return cartPage();
    //   },
    // ),
  ],
);

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    String userId;
    final user = FirebaseAuth.instance.currentUser;
    userId = user!.uid.toString();
    Provider.of<Cart>(context).cartUser(userId);
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // if (true) {
            // if (user.emailVerified) {
            return const HomePage();
          // } else {
          //   return const Login();
          // }
          // } else {
          //   return const Login();
          // }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction { logout }

//write function to display dialog

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
                Navigator.of(context).pop(true);
              },
              child: const Text("Log out"))
        ],
      );
    },
  ).then((value) => value ?? false);
}

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

// class CartList extends ChangeNotifier {
//   Map<String, CartItem> _cart = {};

//   Map<String, CartItem> get cart => {..._cart};

//   void addToCart({required String productId, price, title, image}) {
//     // When a item is added to the cart that already exists, update quantity by one
//     if (_cart.containsKey(productId)) {
//       _cart.update(
//           productId,
//           (value) => CartItem(
//               id: value.id,
//               title: value.title,
//               // image: value.image,
//               price: value.price,
//               qty: value.qty +1
//               ));
//       notifyListeners();
//     }
//     // If the item is not in the cart, add it
//     else {
//       _ca.putIfAbsent(productId,()=> CartItem(
//         id: DateTime.now().toString(),
//         title: title.toString(),
//         price: price.toString(),
//         qty: 1,
//       ));
//     }
//     notifyListeners();
//   }

//   void clearCart() {
//     _cart.clear();
//     notifyListeners();
//   }

//   void removeCart(item) {
//     _cart.remove(item);
//     notifyListeners();
//   }

//   double get totalToPay{
//     double total = 0.0;


//     return total;
//   }
// }

// class ElevatedCardExample extends StatelessWidget {
//   const ElevatedCardExample(
//       {super.key,
//       required this.title,
//       required this.img,
//       required this.cardColor,
//       required this.price,
//       required this.fontColor});

//   final String title;
//   final String img;
//   final String cardColor;
//   final String fontColor;
//   final int price;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [
//               Colors.blue,
//               Colors.red,
//             ],
//           ),
//           // color: hexStringToColor(cardColor),
//           // borderRadius: BorderRadius.circular(40.0),

//           boxShadow: [
//             const BoxShadow(
//               color: Color.fromARGB(30, 0, 0, 0),
//               spreadRadius: 1,
//               blurRadius: 4,
//               offset: Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//         width: 200,
//         height: 220,
//         child: Padding(
//           padding: const EdgeInsets.all(11.0),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Image.asset(img),
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                       color: hexStringToColor(fontColor),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.star,
//                         color: Colors.amber[300],
//                         size: 14,
//                       ),
//                       Icon(
//                         Icons.star,
//                         color: Colors.amber[300],
//                         size: 14,
//                       ),
//                       Icon(
//                         Icons.star,
//                         color: Colors.amber[300],
//                         size: 14,
//                       ),
//                       Icon(
//                         Icons.star_border_outlined,
//                         color: Colors.amber[300],
//                         size: 14,
//                       ),
//                       Icon(
//                         Icons.star_border_outlined,
//                         color: Colors.amber[300],
//                         size: 14,
//                       ),
//                     ],
//                   ),
//                   Text("\$$price",
//                       style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.w600,
//                           color: hexStringToColor(fontColor))),
//                 ],
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
