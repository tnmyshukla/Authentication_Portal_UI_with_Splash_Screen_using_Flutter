import 'package:flutter/material.dart';
import 'package:pho_pro/screens/widgets/custom_shape.dart';
import 'package:pho_pro/screens/widgets/customappbar.dart';
import 'package:pho_pro/screens/widgets/responsive_ui.dart';
import 'package:pho_pro/screens/widgets/textformfield.dart';
import 'package:pho_pro/services/auth.dart';
import 'package:pho_pro/shared/constants.dart';
import 'package:pho_pro/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validatePasswordLength(String value) {
    if (value.length == 0) {
      return "Password can't be empty";
    } else if (value.length < 10) {
      return "Password must be longer than 10 characters";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  String email;
  String password;
  String error = '';
  String firstName;
  String lastName;
  String phone;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return loading?Loading(): Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(
                  opacity: 0.88,
                ),
                clipShape(),
                form(),
                acceptTermsTextRow(),
                SizedBox(
                    // height: _height / 35,
                    ),
                errorText(),
                button(),
                // infoTextRow(),
                // socialIconsRow(),
                signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

//code to use add user profile image
//   Widget clipShape() {
//     return Stack(
//       children: <Widget>[
//         Opacity(
//           opacity: 0.75,
//           child: ClipPath(
//             clipper: CustomShapeClipper(),
//             child: Container(
//               height: _large
//                   ? _height / 8
//                   : (_medium ? _height / 7 : _height / 6.5),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.orange[200], Colors.pinkAccent],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Opacity(
//           opacity: 0.5,
//           child: ClipPath(
//             clipper: CustomShapeClipper2(),
//             child: Container(
//               height: _large
//                   ? _height / 12
//                   : (_medium ? _height / 11 : _height / 10),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.orange[200], Colors.pinkAccent],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Container(
//           height: _height / 5.5,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                   spreadRadius: 0.0,
//                   color: Colors.black26,
//                   offset: Offset(1.0, 10.0),
//                   blurRadius: 20.0),
//             ],
//             color: Colors.white,
//             shape: BoxShape.circle,
//           ),
//           child: GestureDetector(
//               onTap: () {
//                 print('Adding photo');
//               },
//               child: Icon(
//                 Icons.add_a_photo,
//                 size: _large ? 40 : (_medium ? 33 : 31),
//                 color: Colors.orange[200],
//               )),
//         ),
// //        Positioned(
// //          top: _height/8,
// //          left: _width/1.75,
// //          child: Container(
// //            alignment: Alignment.center,
// //            height: _height/23,
// //            padding: EdgeInsets.all(5),
// //            decoration: BoxDecoration(
// //              shape: BoxShape.circle,
// //              color:  Colors.orange[100],
// //            ),
// //            child: GestureDetector(
// //                onTap: (){
// //                  print('Adding photo');
// //                },
// //                child: Icon(Icons.add_a_photo, size: _large? 22: (_medium? 15: 13),)),
// //          ),
// //        ),
//       ],
//     );
//   }
  //Code for icon image
  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: _large
                  ? _height / 30
                  : (_medium ? _height / 25 : _height / 20)),
          child: Image.asset(
            'assets/login.png',
            height: _height / 3.5,
            width: _width / 3.5,
          ),
        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            // firstNameTextFormField(),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: 'First Name',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.person, color: Colors.orange[200]),
                  )),
              validator: (val) {
                // return val.isEmpty ? 'Enter an email' : null;
                return validateName(val);
              },
              onChanged: (val) {
                setState(() {
                  firstName = val;
                });
              },
            ),
            SizedBox(height: _height / 60.0),
            // lastNameTextFormField(),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: 'Last Name',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.person, color: Colors.orange[200]),
                  )),
              validator: (val) {
                return null;
              },
              onChanged: (val) {
                setState(() {
                  lastName = val;
                });
              },
            ),
            SizedBox(height: _height / 60.0),
            // emailTextFormField(),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: 'Email',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.email, color: Colors.orange[200]),
                  )),
              validator: (val) {
                // return val.isEmpty ? 'Enter an email' : null;
                return validateEmail(val);
              },
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
            SizedBox(height: _height / 60.0),
            // phoneTextFormField(),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: 'Mobile Number',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.phone, color: Colors.orange[200]),
                  )),
              validator: (val) {
                // return val.isEmpty ? 'Enter an email' : null;
                return validateMobile(val);
              },
              onChanged: (val) {
                setState(() {
                  phone = val;
                });
              },
            ),
            SizedBox(height: _height / 60.0),
            // passwordTextFormField(),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: 'Password',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.lock, color: Colors.orange[200]),
                  )),
              validator: (val) {
                // return val.length < 6 ? 'Set longer password(>6)' : null;
                return validatePasswordLength(val);
              },
              obscureText: true,
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "First Name",
    );
  }

  Widget lastNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Last Name",
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: "Email ID",
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.phone,
      hint: "Mobile Number",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      icon: Icons.lock,
      hint: "Password",
    );
  }

  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.orange[200],
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  Widget errorText() {
    return Text(
      error,
      style: TextStyle(color: Colors.red, fontSize: 14.0),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        if (checkBoxValue == false) {
          setState(() {
            error = 'Please accept terms and conditions';
          });
        }
        print("Routing to your account");
        if (checkBoxValue == true && _formKey.currentState.validate()) {
          setState(() {
            error = 'Error in credentials';
            loading = true;
          });
          dynamic result = await _auth.registerWithEmailAndPassword(
              email, password, firstName, lastName, phone);
          if (result == null) {
            setState(() {
              error = 'Please enter valid credentials';
              loading = false;
              //loading
            });
          }
        }
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.orange[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'SIGN UP',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Or create using social media",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  Widget socialIconsRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 80.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/googlelogo.png"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/fblogo.jpg"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/twitterlogo.jpg"),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pop(SIGN_IN);
              widget.toggleView();
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange[200],
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }
}
