// Copyright (c) 2017, Joel Trottier-Hebert. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'comedians_service.dart';
import 'package:comiko_shared/models.dart';

@Component(
  selector: 'comedians-list',
  styleUrls: const ['comedians_list_component.css'],
  templateUrl: 'comedians_list_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
  ],
  providers: const [ComediansService],
)
class ComediansListComponent implements OnInit {
  final ComediansService comediansService;

  List<Artist> artists = [];

  ComediansListComponent(this.comediansService);

  @override
  Future<Null> ngOnInit() async {
    artists = await comediansService.getComedians();
  }

  void add() {}

  Artist remove(int index) => artists.removeAt(index);

  void onReorder(ReorderEvent e) =>
      artists.insert(e.destIndex, artists.removeAt(e.sourceIndex));
}
