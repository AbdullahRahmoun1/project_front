import '../dummy_data.dart';
import '../widgets/expert_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/experts.dart';
import '../providers/user.dart';

class SearchScreen extends StatefulWidget {
  static final routName = '/search-screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var expertsData = Provider.of<Experts>(context);
    var experts = expertsData.items;
    // Li> sp = experts.where((element) => element.specialize != null);
    List<User> dispaly_experts = experts;
    TextEditingController? _textEditingController = TextEditingController();

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
        dispaly_experts = result;
        //     .where(
        //       (element) =>
        //           element.name!.toLowerCase().contains(value!.toLowerCase()),
        //       // .where((element) =>
        //       //     element.name!.toLowerCase().contains(value.toLowerCase()))
        //       // .toList()
        //     )
        //     .toList();
      });
    }

    return Scaffold(
      appBar: AppBar(
          // title: Container(
          //   margin: EdgeInsets.only(top: 10, bottom: 10),
          //   child: TextField(
          //     style: TextStyle(color: Colors.deepPurple),
          //     decoration: InputDecoration(
          //       filled: true,
          //       fillColor: Color.fromARGB(255, 235, 235, 235),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(15),
          //         borderSide: BorderSide.none,
          //       ),
          //       hintText: 'You can enter the name of the specialty',
          //       prefixIcon: Icon(Icons.search),
          //       prefixIconColor: Colors.deepPurple,
          //     ),
          //   ),
          // ),
          ),
      drawer: const Drawer(),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Text(
                'Search for expert',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                onSubmitted: (value) {
                  setState(() {
                    expertsData.searchItem(value);
                  });
                },
                controller: _textEditingController,
                style: TextStyle(color: Colors.deepPurple),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 235, 235),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'ُEnter your expert name like \'Alaa\'',
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.deepPurple,
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
