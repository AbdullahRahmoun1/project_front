import '../modles/specialize.dart';

import '../widgets/expert_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/experts.dart';
import '../providers/user.dart';
import '../widgets/app_drawer.dart';

class SearchScreen extends StatefulWidget {
  static final routName = '/search-screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var expertsData = Provider.of<Experts>(context, listen: false);
    var experts = expertsData.items;
    // Li> sp = experts.where((element) => element.specialize != null);
    var dispaly_experts = experts;

    void updateList(String? value) {
      List<User> result = [];
      if (value!.isEmpty) {
        dispaly_experts = result;
      } else {
        result = experts
            .where(
              (element) => element.name!.toLowerCase().contains(
                    value.toLowerCase(),
                  ),
            )
            .toList();
      }
      setState(() {
        dispaly_experts = expertsData.searchItem(value);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: mySearchDelegate(),
              );
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: dispaly_experts.length == 0
                  ? Center(
                      child: Text(
                        'No result found!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: dispaly_experts.length,
                      itemBuilder: (context, index) =>
                          ChangeNotifierProvider.value(
                            value: dispaly_experts[index],
                            child: ExpertWidget(),
                          )),
            ),
          ],
        ),
      ),
    );
  }
}

class mySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else
            query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null); //close search bar
        },
        icon: Icon(
          Icons.arrow_back,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    var expertsData = Provider.of<Experts>(context);
    var experts = expertsData.items;
    final filtterExpert = experts
        .where((element) =>
            element.spForSearch.contains(query) ||
            element.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: filtterExpert[index],
        child: ExpertWidget(),
      ),
      itemCount: filtterExpert.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String?> sp =
        Provider.of<Experts>(context, listen: false).specializes.toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        final suggestion = sp[index];
        return ListTile(
          title: Text(suggestion!),
          onTap: () {
            query = suggestion;
          },
        );
      },
      itemCount: sp.length,
    );
  }
}
