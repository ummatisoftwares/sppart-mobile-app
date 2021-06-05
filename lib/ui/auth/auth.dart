import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:spraat/model/brand.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/item.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/app_localization.dart';
import 'package:spraat/ui/auth/button.dart';
import 'package:spraat/ui/auth/model.dart';
import 'package:provider/provider.dart';
import 'package:spraat/services/auth_service.dart';

import 'package:stacked/stacked.dart';

class AuthView extends StatelessWidget {
  final Brand selectedBrand;
  final CarType selectedType;
  final CarYear selectedYear;
  final CarEngine selectedEngine;
  final Category selectedCategory;
  final Item selectedItem;

  const AuthView(
      {Key key,
      this.selectedBrand,
      this.selectedType,
      this.selectedYear,
      this.selectedEngine,
      this.selectedCategory,
      this.selectedItem,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          Provider(create: (context) => AuthBloc()),
          ListenableProvider(create: (context) => GoogleSignInProvider(),
        )],
          child: ViewModelBuilder<AuthModel>.reactive(
            onModelReady: (model) =>
                model.init(
                    brand: selectedBrand,
                    type: selectedType,
                    year: selectedYear,
                    engine: selectedEngine,
                    category: selectedCategory,
                    item: selectedItem,),
            viewModelBuilder: () => AuthModel(),
            builder: (context, model, child) {
              //bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
              final GoogleProvider = Provider.of<GoogleSignInProvider>(context, listen: false);
              final FacebookProvider = Provider.of<AuthBloc>(context);

              return Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xffFAFBFB),
                        Colors.blueGrey[100]
                      ], // red to yellow FAFBFB ECEEEF
                    ),
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.140),
                        Padding(
                            padding: const EdgeInsets.only(left: 36.0),
                            child: Image.asset(
                                "assets/logo_dark.png", height: 180)
                        ),
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.100),
                        //isIOS ? AppleSignInButton(onPressed: () {}, style: AppleButtonStyle.black, text: "Sign up with Apple", borderRadius: 18,): Container(),
                        //isIOS ? SizedBox(height: 12) : SizedBox(),
                        Text("Sign up for best spare parts deals",
                            style: TextStyle(fontSize: 20,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 32),
                        GoogleSignInButton(onPressed: () {GoogleProvider.login(); model.signIn(context);}, text: "Sign up with Google", borderRadius: 18,),
                        SizedBox(height: 12),
                        FacebookSignInButton(onPressed: () {FacebookProvider.loginFacebook(); model.signIn(context);},
                          text: "Sign up with Facebook",
                          borderRadius: 18,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 28, 24, 28),
                              height: 2,
                              width: 100,
                              color: Colors.blueGrey[200],),
                            //Divider(thickness: 2, indent: 60, endIndent: 60, height: 56,),
                            Text("OR", style: TextStyle(fontSize: 18,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w500)),
                            Container(
                              margin: EdgeInsets.fromLTRB(24, 28, 0, 28),
                              height: 2,
                              width: 100,
                              color: Colors.blueGrey[200],),
                          ],
                        ),
                        SpraatSignInButton(onPressed: () {
                          model.moveToRegister();
                        }, text: "Sign Up with Email", borderRadius: 18),

                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("Already have an account? "),
                            GestureDetector(onTap: () {
                              model.moveToLogin();
                            },
                                child: Text("Sign In", style: TextStyle(
                                    color: Color(0xFF226B95),
                                    fontWeight: FontWeight.w500)))
                          ],
                        ),
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.08),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}


// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceAround,
//   children: [
//     InkWell(
//       onTap: () => model.moveToRegister(),
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.4,
//         height: 80,
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.white, width: 2),
//             color: Colors.transparent),
//         child: Center(
//           child: Text(
//             AppLocalizations.of(context)
//                 .translate('register'),
//             style:
//                 TextStyle(fontSize: 18, color: Colors.white),
//           ),
//         ),
//       ),
//     ),
//     InkWell(
//       onTap: () => model.moveToLogin(),
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.4,
//         height: 80,
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.white, width: 2),
//             color: Colors.transparent),
//         child: Center(
//           child: Text(
//             AppLocalizations.of(context).translate('login'),
//             style:
//                 TextStyle(fontSize: 18, color: Colors.white),
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
