import 'package:flutter/material.dart';
import '../modles/specialize.dart';
import '../server/server.dart';

class ExpertInfoScreen extends StatefulWidget {
  static final routName = '/expert-info';

  @override
  State<ExpertInfoScreen> createState() => _ExpertInfoScreenState();
}

class _ExpertInfoScreenState extends State<ExpertInfoScreen> {
  bool? _isInit = true;
  bool _isLoading = true;
  String? _userName = '';
  String? _userPhone = '';
  String? _userImage = '';
  String? _userDis = '';
  String? _idSp = '';
  String? _userAdress = '';
  String? _price;
  String? _totalRate;
  String? _creditCard;
  bool _isFav = false;
  String? _expertId;
  List<Specialize> _spec = [];
  Specialize currentIndex = Specialize('', '', '', '', '', '');
  var _selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    _expertId = ModalRoute.of(context)?.settings.arguments as String?;
    if (_isInit!) {
      setState(() {
        _isLoading = true;
      });
      try {
        dynamic extraxtData = await srvr.getUserData(_expertId, context);
        setState(() {
          _spec = extraxtData['specialize'];
          _userName = extraxtData['name'];
          _userPhone = extraxtData['phone'];
          _userImage = extraxtData['image'];
          _isFav = extraxtData['isFav'];
          _creditCard = extraxtData['money'].toString();
          _totalRate = extraxtData['totalRate'].toString();
          _price = _spec[0].price.toString();
          _userDis = _spec[0].discription;
          _userAdress = _spec[0].adress;
          _idSp = _spec[0].id;
          _selectedValue = _spec[0].name;
          _isLoading = false;
        });
      } catch (e) {
        print(e);
      }

      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void back(BuildContext context) {
    Navigator.of(context).pop(ExpertInfoScreen.routName);
  }

  void _showToast(String text, BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      width: double.infinity,
                      height: 270,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70),
                        ),
                      ),
                      child: Image(
                        image: AssetImage('assets/images/stars.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      //thins container for avatar and name
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      width: double.infinity,
                      height: 270,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(103, 58, 183, 110),
                            Color.fromRGBO(156, 39, 176, 110),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  onTap: () => back(context),
                                  child: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 72,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "http://$baseUrl:8000/api/" + _userImage!),
                              backgroundColor: Colors.white,
                              radius: 70,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: Text(
                              _userName!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 7,
                      right: 20,
                      child: IconButton(
                          icon: (Icon(
                            _isFav ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                            size: 25,
                          )),
                          onPressed: () {
                            setState(() {
                              srvr.manageLove(_expertId!, context);
                              _isFav = !_isFav;
                            });
                          }),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 10, right: 15, left: 15, bottom: 10),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //   margin: EdgeInsets.only(left: 30, right: 30),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      //       IconButton(
                      //         icon: Icon(
                      //           Icons.credit_card,
                      //           color: Colors.grey,
                      //           size: 35,
                      //         ),
                      //         onPressed: () {},
                      //       ),
                      //       Text(
                      //         '${_creditCard.toString()}\$',
                      //         style: TextStyle(
                      //           color: Color.fromARGB(255, 113, 113, 113),
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 16,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.star_rate_rounded,
                              color: Colors.grey,
                              size: 35,
                            ),
                            Text(
                              _totalRate.toString(),
                              style: TextStyle(
                                color: Color.fromARGB(255, 113, 113, 113),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.monetization_on_sharp,
                              color: Colors.grey,
                              size: 35,
                            ),
                            Text(
                              '${_price.toString()}\$',
                              style: TextStyle(
                                color: Color.fromARGB(255, 113, 113, 113),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // this container for info
                  margin: const EdgeInsets.only(
                      top: 5, right: 15, left: 15, bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),

                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DropdownButtonFormField(
                                icon: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.deepPurple,
                                  size: 30,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Select specialize',
                                ),
                                value: _selectedValue,
                                items: _spec
                                    .map(
                                      (e) => DropdownMenuItem(
                                        child: Text(e.name!),
                                        value: e.name,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  currentIndex = _spec.firstWhere(
                                    (element) {
                                      return element.name == value;
                                    },
                                  );
                                  setState(() {
                                    _selectedValue = value;
                                    _userDis = currentIndex.discription;
                                    _userAdress = currentIndex.adress;
                                    _price = currentIndex.price;
                                  });
                                },
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 25),
                                child: Text(
                                  'Description :',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 20),
                                child: Text(
                                  _userDis!,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 113, 113, 113),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(
                                'Contact :',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 20),
                                child: Text(
                                  _userPhone!,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 113, 113, 113),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(
                                'Address :',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 20),
                                child: Text(
                                  _userAdress!,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 113, 113, 113),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
              ],
            ),
    );
  }
}
