import 'package:flutter/material.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/item.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/app_localization.dart';
import 'package:spraat/ui/auth/button.dart';
import 'package:provider/provider.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:stacked/stacked.dart';

import 'model.dart';

class LoginView extends StatelessWidget {
  final Brand selectedBrand;
  final CarType selectedType;
  final CarYear selectedYear;
  final CarEngine selectedEngine;
  final Category selectedCategory;
  final Item selectedItem;

  const LoginView(
      {Key key,
      this.selectedBrand,
      this.selectedType,
      this.selectedYear,
      this.selectedEngine,
      this.selectedCategory,
      this.selectedItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers:[
        Provider(create: (context) => AuthBloc()),
        ListenableProvider(create: (context) => GoogleSignInProvider(),
        )],
      child: ViewModelBuilder<LoginModel>.reactive(
        onModelReady: (model) => model.init(
            brand: selectedBrand,
            type: selectedType,
            year: selectedYear,
            engine: selectedEngine,
            category: selectedCategory,
            item: selectedItem),
        viewModelBuilder: () => LoginModel(),
        builder: (context, model, child) {

          // bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
          final GoogleProvider = Provider.of<GoogleSignInProvider>(context, listen: false);
          final FacebookProvider = Provider.of<AuthBloc>(context);

          return Scaffold(
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
                    "Sign In",
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
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration.collapsed(
                                  hintText: "Password", hintStyle: TextStyle(color: Colors.blueGrey))
                          )
                      )
                  ),
                  SizedBox(height: 20),
                  SpraatSignInButton(onPressed: (){model.login();} ,text: "Sign In", borderRadius: 18, padding: 60,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(margin: EdgeInsets.fromLTRB(0, 28, 24, 28),height: 2, width: 100, color: Colors.blueGrey[200],),
                      //Divider(thickness: 2, indent: 60, endIndent: 60, height: 56,),
                      Text("OR", style: TextStyle( fontSize: 18 ,color: Colors.blueGrey, fontWeight: FontWeight.w500)),
                      Container(margin: EdgeInsets.fromLTRB(24, 28, 0, 28),height: 2, width: 100, color: Colors.blueGrey[200],),
                    ],
                  ),
                  GoogleSignInButton(onPressed: (){GoogleProvider.login();},text: "Sign In with Google", borderRadius: 18,),
                  SizedBox(height: 12),
                  FacebookSignInButton(onPressed:(){FacebookProvider.loginFacebook();}, text: "Sign In with Facebook", borderRadius: 18,),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Don't have an Account? "),
                      GestureDetector(onTap: (){model.moveBack();} ,child: Text("Sign Up", style: TextStyle(color: Color(0xFF226B95), fontWeight: FontWeight.w500)))
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.08),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/*
Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.jpeg"),
                    fit: BoxFit.cover)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/logo.png"),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context).translate('email'),
                            style:
                                TextStyle(color: Colors.black87, fontSize: 20)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: TextField(
                                    style: TextStyle(color: Colors.black),
                                    controller: model.emailController,
                                    decoration: InputDecoration.collapsed(
                                        hintText: null)))),
                        SizedBox(
                          height: 20,
                        ),
                        Text(AppLocalizations.of(context).translate('password'),
                            style:
                                TextStyle(color: Colors.black87, fontSize: 20)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: TextField(
                                    style: TextStyle(color: Colors.black),
                                    controller: model.passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration.collapsed(
                                        hintText: null)))),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // InkWell(onTap: ()=>model.forgotPassword(),child: Text("Forgot passowrd?"),),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () => model.login(),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context).translate('login'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
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
*/