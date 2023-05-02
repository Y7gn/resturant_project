import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class searchView extends StatefulWidget {
  const searchView({super.key});

  @override
  State<searchView> createState() => _searchViewState();
}

class _searchViewState extends State<searchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Search For an Item",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w300),),
        actions: [IconButton(onPressed: () {
          showSearch(context: context, delegate: DataSearch());
        }, icon: const Icon(Icons.search,color: Colors.black,))],
      ),
      
    );
  }
}

class DataSearch extends SearchDelegate {

  List names = [
    "wael",
    "basel",
    "mohamad",
    "yaser",
    "shady",
    "mohamad",
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.close), onPressed: () {
      query="";
    })];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context,null);
    }, icon: Icon(Icons.arrow_back));
  }

    @override
    Widget buildResults(BuildContext context) {
      return Text("$query");
    }

    @override
    Widget buildSuggestions(BuildContext context) {

      List filternames = names.where((element) => element.contains(query)).toList();
      return ListView.builder(
        
        itemCount: query == ""? names.length : filternames.length,
        itemBuilder: (context,i) {
          return InkWell(
            onTap: (){
              query = query == ""? names[i] : filternames.length;
              showResults(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: query == ""? Text(
                "${names[i]}",
                style: TextStyle(fontSize: 25),
              ):Text(
                "${filternames[i]}",
                style: TextStyle(fontSize: 25),
              )
            ),
          );
        },
      );
    }
}
