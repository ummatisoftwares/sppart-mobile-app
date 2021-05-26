import 'package:firebase_auth/firebase_auth.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/item.dart';
import 'package:spraat/model/offer.dart';
import 'package:spraat/model/request.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:spraat/services/push_notification_service.dart';
import 'package:spraat/ui/core/views/feed/pages/step0.dart';
import 'package:spraat/ui/core/views/feed/request_preview/request.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FeedModel extends BaseViewModel {
  final _firestoreService = locator<FirestoreService>();
  final _navigationService = locator<NavigationService>();
  final _auth = locator<AuthService>();
  final _notify = locator<PushNotificationService>();
  List<Request> requests = List<Request>();
  List<Item> items = List<Item>();
  List<Brand> brnds = List<Brand>();


  init() async {
    setBusy(true);
    await _notify.initialize();
    User user = await _auth.getUser();
    if (user != null) {
      await getRequests(user.uid);
    }
    brnds = await _firestoreService.retrieveBrands();
    setBusy(false);
  }

  getRequests(String userId) async {
    requests = await _firestoreService.retrieveRequests(userId);
    print(userId);
    notifyListeners();
  }

  addRequest() {
    _navigationService.navigateToView(Step0());
  }

  previewRequest(Request req) {
    _navigationService.navigateToView(
      RequestPreview(selectedRequestID: req.id),
    );
  }

  Brand getBrand(String ID){
      Brand temp;
      brnds.forEach((element) {
        if(element.id == ID){
          temp = element;
        }
      });
      return temp;
  }
}
