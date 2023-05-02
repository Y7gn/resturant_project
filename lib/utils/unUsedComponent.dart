import 'package:flutter/material.dart';

class OutlinedCardExample extends StatelessWidget {
  const OutlinedCardExample(
      {super.key, required this.categoryImg, required this.categoryTitle});
  final String categoryImg;
  final String categoryTitle;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(7, 0, 0, 0),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(categoryImg, width: 50, height: 50),
                SizedBox(
                  width: 120,
                  height: 30,
                  child: Center(
                    child: Container(
                      child: Text(categoryTitle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
