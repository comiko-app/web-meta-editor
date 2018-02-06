// Copyright (c) 2017, Joel Trottier-Hebert. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:comedian_images_selector/routes.dart' as routes;
import 'package:comedian_images_selector/services.dart';
import 'package:firebase/firebase.dart';

@Component(
  selector: 'dashboard',
  styleUrls: const ['dashboard_component.css'],
  templateUrl: 'dashboard_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    materialDirectives,
    materialInputDirectives,
    MaterialInputComponent,
  ],
)
class DashboardComponent implements OnInit {
  final Router router;
  final ComediansService comediansService;
  final FirebaseService firebaseService;

  Auth auth;

  @Input()
  bool isLoggedIn = false;

  DashboardComponent(this.router, this.comediansService, this.firebaseService) {
    auth = firebaseService.app.auth();
  }

  void navigateToComedians() {
    router.navigate(routes.comediansRoute.path);
  }

  Future<Null> optimizeImages() => comediansService.optimizeImages();

  Future<Null> clearAllImages() => comediansService.clearAllImages();

  Future<Null> initLogin() async {
    var auth = firebaseService.app.auth();
    var credentials = await auth.signInWithPopup(new GoogleAuthProvider());

    await auth.signInWithCredential(credentials.credential);
  }

  Future<Null> logout() => auth.signOut();

  @override
  ngOnInit() {
    auth.onAuthStateChanged.listen((User u) {
      isLoggedIn = u != null;
    });
  }
}
