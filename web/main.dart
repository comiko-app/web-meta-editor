// Copyright (c) 2017, Joel Trottier-Hebert. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';

import 'package:comedian_images_selector/app_component.dart';
import 'package:angular_router/angular_router.dart';

import 'package:comedian_images_selector/services.dart';

// Automatically generated at compile-time.
// ignore: uri_has_not_been_generated
import 'main.template.dart' as ng;

void main() {
  bootstrapStatic(
      AppComponent,
      [
        routerProviders,
        provide(LocationStrategy, useClass: HashLocationStrategy),
        const ClassProvider(ComediansService),
      ],
      ng.initReflector);
}
