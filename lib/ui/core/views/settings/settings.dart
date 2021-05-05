import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spraat/services/app.dart';
import 'package:spraat/services/app_localization.dart';

import 'package:stacked/stacked.dart';

import 'model.dart';

class SettingsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var app = Provider.of<AppProvider>(context);
    return ViewModelBuilder<SettingsModel>.reactive(
      onModelReady: (model) => model.init(context),
      viewModelBuilder: () => SettingsModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).translate('settings'),
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
              : Column(
            children: [
              ListTile(
                onTap: () {
                  openLangDialog(context, app);
                  //app.changeLanguage();
                },
                title: Text("Language"),
                trailing: Container(
                  child: Text(app.lang),
                ),
              ),
              ListTile(
                title: Text(
                    AppLocalizations.of(context).translate('darkMode') ??
                        ""),
                trailing: Switch(
                    activeColor: Theme
                        .of(context)
                        .primaryColor,
                    value: model.isDarkMode,
                    onChanged: (value) => model.switchThemes(context)),
              ),
              ListTile(
                title: Text(
                    AppLocalizations.of(context).translate('rateApp') ??
                        ""),
                trailing: IconButton(
                    icon: Icon(Icons.star_rate),
                    onPressed: () => model.rateApp()),
              ),
              ListTile(
                title: Text(
                    AppLocalizations.of(context).translate('privacyPolicy') ??
                        ""),
                trailing: IconButton(
                    icon: Icon(Icons.admin_panel_settings),
                    onPressed: () =>
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Privacy Policy")))),
              ),
              ListTile(
                title: Text(
                    AppLocalizations.of(context).translate('feedback') ??
                        ""),
                trailing: IconButton(
                    icon: Icon(Icons.feedback),
                    onPressed: () =>
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Feedback")))),
              ),
              ListTile(
                title: Text(model.user == null
                    ? AppLocalizations.of(context).translate('login')
                    : AppLocalizations.of(context).translate('logout')),
                trailing: IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () =>
                    model.user == null
                        ? model.login()
                        : model.logout()),
              ),
            ],
          ),
        );
      },
    );
  }


  openLangDialog(BuildContext context, AppProvider app) {

    List<String> languages = ['English', 'Urdu'];

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
            elevation: 16,
            child: Container(
              //height: 360.0,
              //width: 360.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      "Languages",
                      style: TextStyle(fontSize: 20,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16),
                  //Container(height: 1, color: Colors.blueGrey[200]),
                  ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: (){
                              if(app.lang != languages[index]) {
                                app.changeLanguage();
                                Navigator.of(context, rootNavigator: true).pop();
                              }
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(height: 1, color: Colors.blueGrey[200]),
                                SizedBox(height: 16),
                                Text(languages[index], style: TextStyle(fontSize: 16),),
                                SizedBox(height: 16),
                              ],
                            ),
                          );
                        },
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
          );
        }
    );
  }

}