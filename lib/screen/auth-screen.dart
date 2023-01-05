import 'package:consulting_app/modles/http_exception.dart';
import 'package:provider/provider.dart';

import '../screen/tabs_screen.dart';

import 'package:flutter/material.dart';

import '../server/auth.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image(
              image: AssetImage('assets/images/cosn.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(103, 58, 183, 60),
                  Color.fromRGBO(140, 100, 207, 60),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Flexible(
                  //   child: Container(
                  //     margin: EdgeInsets.only(bottom: 20.0),
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                  //     transform: Matrix4.rotationZ(-8 * pi / 180)
                  //       ..translate(-10.0),
                  //     // ..translate(-10.0),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: Colors.deepOrange.shade900,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           blurRadius: 8,
                  //           color: Colors.black26,
                  //           offset: Offset(0, 2),
                  //         )
                  //       ],
                  //     ),
                  //     child: Text(
                  //       'MyShop',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 50,
                  //         fontFamily: 'Anton',
                  //         fontWeight: FontWeight.normal,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
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

class AuthCard extends StatefulWidget {
  // const AuthCard({
  //   Key? key,
  // }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _phone = FocusNode();
  final _password = FocusNode();
  final _rePassword = FocusNode();

  @override
  void dispose() {
    _phone;
    _password;
    _rePassword;
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {'email': '', 'password': '', 'name': ''};
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDilogMessage(String? massage) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('We have error GG'),
              content: Text(massage!),
              actions: <Widget>[
                TextButton(
                  child: Text('ok'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false)
            .LogIn(_authData['email'], _authData['password']);
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).SignUp(
            _authData['name'], _authData['email'], _authData['password']);
      }
    } on HttpException catch (error) {
      var errorMessage = 'How can you be in this bad to get this error';
      if (error.toString().contains('The selected phone is invalid.')) {
        errorMessage =
            'Your phone number or password is not correct,please try again';
      }
      _showErrorDilogMessage(errorMessage);
    } catch (error) {
      var errorMessage = 'Some thing went wrong try again later';
      _showErrorDilogMessage(errorMessage);
    }

    // Navigator.of(context).pushReplacementNamed(TabsScreen.routName);
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  // File? _image;

  // Future<File> saveImagePermanently(String path) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(path);
  //   final image = File('${directory.path}/$name');

  //   return File(path).copy(image.path);
  // }

  // Future _pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     // File? imgTemporary = File(image.path);
  //     final imagePermanent = await saveImagePermanently(image.path);
  //     setState(() {
  //       _image = imagePermanent;
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        height: _authMode == AuthMode.Signup ? 490 : 360,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 420 : 260),
        width: deviceSize.width,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_phone);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Just enter your name!';
                      }
                      if (value.length < 2) {
                        return 'This is a name for dog , Enter good name :)';
                      }
                    },
                    onSaved: (newValue) {
                      _authData['name'] = newValue!;
                    },
                  ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone-Number'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Invalid Phone number!';
                    }
                    if (RegExp(r'.[A-Za-z]').hasMatch(value)) {
                      return 'Invalid Phone number!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  controller: _passwordController,
                  focusNode: _password,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_rePassword);
                  },
                  validator: (value) {
                    if (value!.isEmpty || value.length < 2) {
                      return 'How can you forget your password!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    focusNode: _rePassword,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 40,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child: Text(
                      _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    onPressed: _submit,
                  ),
                TextButton(
                  child: RichText(
                    text: _authMode == AuthMode.Login
                        ? TextSpan(
                            children: [
                              TextSpan(
                                text: 'You dont\'t have account? ',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                    fontSize: 18),
                              ),
                            ],
                          )
                        : TextSpan(
                            children: [
                              TextSpan(
                                text: 'You already has account? ',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                              TextSpan(
                                text: 'Log in',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                  ),
                  onPressed: _switchAuthMode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
