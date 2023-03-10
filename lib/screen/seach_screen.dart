import '../widgets/expert_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/experts.dart';
import '../providers/user.dart';
import '../widgets/app_drawer.dart';
import '../server/server.dart';
import '../providers/categories.dart';

class SearchScreen extends StatefulWidget {
  static final routName = '/search-screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _isInit = true;
  var _isLoaded = true;
  bool _isExpert = false;
  static String categoryId="-1";//change it to yours
  static String categoryName="All";//also this

  String _userName = '';
  String _userPhone = '';
  String _userImage = '';
  List<User>experts=[];
 // to change the hint value
 // mySearchDelegate.categoryName="";

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() async {
    var items = Provider.of<Categories>(context).items;
    try {
      dynamic extraxtData =
          await srvr.getUserData('-1');
      _userName = extraxtData['name'];
      _userPhone = extraxtData['phone'];
      _userImage = extraxtData['image'];
      _isExpert = extraxtData['isExp'];
      srvr.search('-1',"").then((value){
        setState(() {
          experts=value.items;
          _isLoaded = false;
        });

      });
    } catch (e) {
      print(e);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var dispaly_experts = experts;
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
      drawer: AppDrawer(_userName, _userPhone, _userImage),
      body:_isLoaded? Center(
        child: CircularProgressIndicator(),
      ):Container(
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
  List<User> filtterExpert =[];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }
  @override
  String? get searchFieldLabel => 'Search in ${_SearchScreenState.categoryName} category';
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
  Widget buildResults(BuildContext context){
    return FutureBuilder(future:srvr.search(_SearchScreenState.categoryId.toString(), query.toString())
        ,builder: (context, AsyncSnapshot<Experts> snapshot) {
          if(snapshot.hasData){
            filtterExpert=snapshot.data!.items;
            print('-_______________________-');
            print(snapshot.data?.items);
            print('********');
            print(filtterExpert);
            return ListView.builder(
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: filtterExpert[index],
                child: ExpertWidget(),
              ),
              itemCount: filtterExpert.length,
            );
            return Text(snapshot.data.toString());
          }else if(snapshot.hasError){
            return Center(child: Text("No items Found"));
          }else {
            return Center(child: CircularProgressIndicator());
          }
        });

    //
    //  List<User> filtterExpert =[];
    // Provider.of<Server>(context).search("1", "b", context).then((exps) {
    //   filtterExpert=exps.items;
    //
    //   print(filtterExpert);
    // }
    // );
    // Provider.of<Server>(context)
    //         .search("2", "bwindler", context)
    //         .then((exps) {
    //           filtterExpert = exps.items;
    //           });
    // return ListView.builder(
    //   itemBuilder: (context, index) => ChangeNotifierProvider.value(
    //     value: filtterExpert[index],
    //     child: ExpertWidget(),
    //   ),
    //   itemCount: filtterExpert.length,
    // );
    // return StatefulBuilder(builder: builder)
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
