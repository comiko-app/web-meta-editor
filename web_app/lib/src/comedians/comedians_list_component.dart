// Copyright (c) 2017, Joel Trottier-Hebert. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'comedians_service.dart';

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

  List<String> items = [];
  String newTodo = '';

  ComediansListComponent(this.comediansService);

  @override
  Future<Null> ngOnInit() async {
    items = await comediansService.getTodoList();
  }

  void add() {
    items.add(newTodo);
    newTodo = '';
  }

  String remove(int index) => items.removeAt(index);
  void onReorder(ReorderEvent e) =>
      items.insert(e.destIndex, items.removeAt(e.sourceIndex));
}
