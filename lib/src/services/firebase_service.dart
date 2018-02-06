import 'package:angular/angular.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';

@Injectable()
class FirebaseService {
  static Map<String, String> config = {
    'apiKey': "AIzaSyCofRdDQb-Han2Qe4JHENgiT-rsW2UOwYE",
    'authDomain': "comiko-3916d.firebaseapp.com",
    'databaseURL': "https://comiko-3916d.firebaseio.com",
    'projectId': "comiko-3916d",
    'storageBucket': "comiko-3916d.appspot.com",
    'messagingSenderId': "906402477789",
  };

  Firestore fs;
  Storage storage;
  Auth auth;

  App get app => _app;
  App _app;

  FirebaseService() {
    _app = initializeApp(
        apiKey: config['apiKey'],
        authDomain: config['authDomain'],
        databaseURL: config['databaseURL'],
        projectId: config['projectId'],
        storageBucket: config['storageBucket'],
        name: 'Debug');
    fs = app.firestore();
    storage = app.storage();
    auth = app.auth();
  }
}
