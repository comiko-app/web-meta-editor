// Copyright (c) 2017, Joel Trottier-Hebert. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:comiko_shared/models.dart';

import 'comedian_component.dart';
import 'comedians_service.dart';

@Component(
  selector: 'comedians-list',
  styleUrls: const ['comedians_list_component.css'],
  templateUrl: 'comedians_list_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    const [ComedianComponent]
  ],
)
class ComediansListComponent implements OnInit {
  final ComediansService comediansService;

  Map<String, Artist> artists = {};

  ComediansListComponent(this.comediansService);

  @override
  Future<Null> ngOnInit() async {
    comediansService.getArtistsAsStream().listen((Artist artist) {
      if (artist.deleted) {
        artists.remove(artist.id);
      } else {
        artists[artist.id] = artist;
      }
    });
  }
}
