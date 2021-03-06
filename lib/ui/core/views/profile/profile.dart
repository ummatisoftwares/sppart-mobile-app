import 'package:flutter/material.dart';
import 'package:spraat/services/app_localization.dart';

import 'model.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => ProfileModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).translate('profile'),
            ),
          ),
          body: model.isBusy
              ? Container(
                  child: Center(
                      child: Container(
                    height: 5,
                    width: 50,
                    child: LinearProgressIndicator(),
                  )),
                )
              : model.user != null
                  ? Scaffold(
                      body: Container(
                        margin: EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: model.user?.photoURL != null
                                    ? InkWell(
                                        onTap: () => model.canPasswordUpdate()? model.uploadProfileImage(): null,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      model.user.photoURL)),
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.grey.withOpacity(0.4)),
                                          height: 100,
                                          width: 100,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () => model.canPasswordUpdate()? model.uploadProfileImage() : null,
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.grey.withOpacity(0.4)),
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ListView(
                                shrinkWrap: true,
                                children: [
                                  Card(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('name'),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              height: 50,
                                              color: Colors.white12,
                                              child: Center(
                                                  child: TextFormField(
                                                    enabled: model.canPasswordUpdate()? true : false,
                                                controller: model.nameController,
                                              ))),
                                        ],
                                      ),
                                    ),
                                  ),
                                  model.isLoggedInWithFacebook? Card(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('email'),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              height: 50,
                                              color: Colors.white12,
                                              child: Center(
                                                  child: TextFormField(
                                                enabled: false,
                                                controller: model.emailController,
                                              ))),
                                        ],
                                      ),
                                    ),
                                  ) : Container(),
                                  model.canPasswordUpdate() ? Card(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('password'),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              height: 50,
                                              color: Colors.white12,
                                              child: Center(
                                                  child: Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      obscureText: true,
                                                      enabled: model
                                                          .passwordUpdateEndabled,
                                                      controller: model
                                                          .passwordController,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () => model
                                                            .passwordUpdateEndabled
                                                        ? model.updatePassword()
                                                        : model
                                                            .enablePasswordUpdate(),
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                          model.passwordUpdateEndabled
                                                              ? AppLocalizations.of(context).translate('update')
                                                              : AppLocalizations.of(context).translate('change'),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  )
                                                ],
                                              ))),
                                        ],
                                      ),
                                    ),
                                  ) : Container(),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      floatingActionButton: model.canPasswordUpdate()? FloatingActionButton.extended(
                        onPressed: () => model.updateProfile(),
                        label: Text(AppLocalizations.of(context)
                            .translate('updateProfile')),
                        icon: Icon(Icons.save),
                      ) : null,
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('youAreNotLoggedIn'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () => model.login(),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
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
                    ),
        );
      },
    );
  }
}
