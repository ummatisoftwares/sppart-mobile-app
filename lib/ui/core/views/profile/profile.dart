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
                        child: Column(
                          children: [
                            Center(
                              child: model.user?.photoUrl != null
                                  ? InkWell(
                                      onTap: () => model.uploadProfileImage(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    model.user.photoUrl)),
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.grey.withOpacity(0.4)),
                                        height: 200,
                                        width: 200,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () => model.uploadProfileImage(),
                                      child: Container(
                                        height: 200,
                                        width: 200,
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
                                              controller: model.nameController,
                                            ))),
                                      ],
                                    ),
                                  ),
                                ),
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
                                ),
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
                                                            ? "UPDATE"
                                                            : "Change",
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
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      floatingActionButton: FloatingActionButton.extended(
                        onPressed: () => model.updateProfile(),
                        label: Text(AppLocalizations.of(context)
                            .translate('updateProfile')),
                        icon: Icon(Icons.save),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You are not logged in",
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
                                    "LOGIN",
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
