import 'package:flutter/material.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/item.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/app_localization.dart';
import 'package:spraat/ui/auth/button.dart';
import 'package:spraat/ui/register/model.dart';

import 'package:stacked/stacked.dart';

class RegisterView extends StatefulWidget {
  final Brand selectedBrand;
  final CarType selectedType;
  final CarYear selectedYear;
  final CarEngine selectedEngine;
  final Category selectedCategory;
  final Item selectedItem;
  static int count;

  const RegisterView(
      {Key key,
      this.selectedBrand,
      this.selectedType,
      this.selectedYear,
      this.selectedEngine,
      this.selectedCategory,
      this.selectedItem})
      : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  bool agree = false;
  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterModel>.reactive(
      onModelReady: (model) => model.init(
          brand: widget.selectedBrand,
          type: widget.selectedType,
          year: widget.selectedYear,
          engine: widget.selectedEngine,
          category: widget.selectedCategory,
          item: widget.selectedItem),
      viewModelBuilder: () => RegisterModel(),
      builder: (context, model, child) {
        // bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xffFAFBFB), Colors.blueGrey[100]], // red to yellow FAFBFB ECEEEF
              ),
            ),
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Stack(
                      // overflow: Overflow.visible,
                      alignment: AlignmentDirectional.centerStart,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 24),
                          child: InkWell(onTap:(){ model.moveBack(); }, child: Image.asset("assets/back_arrow.png", height: 28, color: Colors.blueGrey[300],)),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.140),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 36.0),
                    child: Image.asset("assets/logo_dark.png", height: 180),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height*0.100),
                  Text(
                    AppLocalizations.of(context).translate('signUp'),
                      //AppLocalizations.of(context).translate('register'),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 42,
                    width: 280,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(18)),
                    child: Center(
                        child: TextField(
                            textAlign: TextAlign.center,
                            controller: model.emailController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration.collapsed(
                                hintText: "example@sppart.com", hintStyle: TextStyle(color: Colors.blueGrey)))
                    )
                  ),
                  SizedBox(height: 20),
                  Container(
                      height: 42,
                      width: 280,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(18)),
                      child: Center(
                          child: TextField(
                              textAlign: TextAlign.center,
                              controller: model.passwordController,
                              obscureText: _obscureText,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(onTap:()=> setState(() {_obscureText = !_obscureText;}),child: Icon(Icons.remove_red_eye,color: Colors.blueGrey[400])),
                                  hintText: AppLocalizations.of(context).translate('password') ?? "", hintStyle: TextStyle(color: Colors.blueGrey),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 42, bottom: 8, top: 8)
                              )
                          )
                      )
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        // activeColor: Colors.white60,
                        // checkColor: Color(0xFF226B95),
                        value: agree,
                        onChanged: (value) {
                          setState(() {
                            agree = value;
                          });
                        },
                      ),
                      Text(AppLocalizations.of(context).translate('agreeTo') + " ",),
                      GestureDetector(onTap: (){ model.goToTerms();} ,child: Text(AppLocalizations.of(context).translate('terms&Conditions'), style: TextStyle(color: Color(0xFF226B95), fontWeight: FontWeight.w500)))
                    ],
                  ),
                  SizedBox(height: 6),
                  agree? SpraatSignInButton(onPressed: (){model.register(); model.signIn(context);} ,text: AppLocalizations.of(context).translate('createAccount'), borderRadius: 18,) : SpraatSignInButton(onPressed: (){} ,text: AppLocalizations.of(context).translate('createAccount'), borderRadius: 18, buttonColor: Color(0xFF226B95).withOpacity(0.6)),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(AppLocalizations.of(context).translate('alreadyHaveAnAccount') + " "),
                      GestureDetector(onTap: (){model.moveToLogin();} ,child: Text(AppLocalizations.of(context).translate('signIn'), style: TextStyle(color: Color(0xFF226B95), fontWeight: FontWeight.w500)))
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.08),
                ],
            ),
          ),
        );
      },
    );
  }
}

//Container(
//   padding: EdgeInsets.all(20),
//   width: double.infinity,
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(15),
//     color: Colors.white,
//   ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(AppLocalizations.of(context).translate('email'),
//           style:
//               TextStyle(color: Colors.black87, fontSize: 20)),
//       SizedBox(
//         height: 10,
//       ),
//       Container(
//           height: 40,
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(15)),
//           child: Center(
//               child: TextField(
//                   controller: model.emailController,
//                   style: TextStyle(color: Colors.black),
//                   decoration: InputDecoration.collapsed(
//                       hintText: null)))),
//       SizedBox(
//         height: 20,
//       ),
//       Text(AppLocalizations.of(context).translate('password'),
//           style:
//               TextStyle(color: Colors.black87, fontSize: 20)),
//       SizedBox(
//         height: 10,
//       ),
//       Container(
//           height: 40,
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(15)),
//           child: Center(
//               child: TextField(
//                   style: TextStyle(color: Colors.black),
//                   controller: model.passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration.collapsed(
//                       hintText: null)))),
//       SizedBox(
//         height: 20,
//       ),
//       Text(
//           AppLocalizations.of(context)
//               .translate('confirmPassword'),
//           style:
//               TextStyle(color: Colors.black87, fontSize: 20)),
//       SizedBox(
//         height: 10,
//       ),
//       Container(
//           height: 40,
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(15)),
//           child: Center(
//               child: TextField(
//                   style: TextStyle(color: Colors.black),
//                   controller: model.confirmController,
//                   obscureText: true,
//                   decoration: InputDecoration.collapsed(
//                       hintText: null)))),
//       SizedBox(
//         height: 20,
//       ),
//       InkWell(
//         onTap: () => model.register(),
//         child: Container(
//           width: double.infinity,
//           height: 50,
//           decoration: BoxDecoration(
//               color: Colors.orange,
//               borderRadius: BorderRadius.circular(15)),
//           child: Center(
//             child: Text(
//               AppLocalizations.of(context)
//                   .translate('register'),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontSize: 18),
//             ),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
