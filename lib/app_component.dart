// Copyright (c) 2017, Joel Trottier-Hebert. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';

import 'routes.dart';
import 'src/comedians/comedians_list_component.dart';
import 'src/dashboard/dashboard_component.dart';

// ignore: uri_has_not_been_generated
import 'src/dashboard/dashboard_component.template.dart' as dashboard_component;

// ignore: uri_has_not_been_generated
import 'src/comedians/comedians_list_component.template.dart'
    as comedians_list_component;

@Component(
  selector: 'my-app',
  styleUrls: const [
    'app_component.css',
    'package:angular_components/app_layout/layout.scss.css',
  ],
  templateUrl: 'app_component.html',
  directives: const [
    routerDirectives,
    materialDirectives,
    ComediansListComponent,
    DashboardComponent,
  ],
  providers: const [materialProviders],
)
class AppComponent {
  final List<RouteDefinition> routes = [
    new RouteDefinition(
      routePath: dashboardRoute,
      component: dashboard_component.DashboardComponentNgFactory,
    ),
    new RouteDefinition(
      routePath: comediansRoute,
      component: comedians_list_component.ComediansListComponentNgFactory,
    ),
  ];
}
