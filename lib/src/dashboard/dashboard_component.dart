// Copyright (c) 2017, Joel Trottier-Hebert. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:comedian_images_selector/routes.dart' as routes;

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

  DashboardComponent(this.router);

  @override
  ngOnInit() {}

  void navigateToComedians() {
    router.navigate(routes.comediansRoute.path);
  }

  Future<Null> optimizeAllPictures() async {

  }
}
