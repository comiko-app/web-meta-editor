// Copyright (c) 2017, Joel Trottier-Hebert. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/core.dart';
import 'package:comiko_shared/models.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';

@Injectable()
class ComediansService {
  Firestore fs;

  static Map<String, String> config = {
    'apiKey': "AIzaSyCofRdDQb-Han2Qe4JHENgiT-rsW2UOwYE",
    'authDomain': "comiko-3916d.firebaseapp.com",
    'databaseURL': "https://comiko-3916d.firebaseio.com",
    'projectId': "comiko-3916d",
    'storageBucket': "comiko-3916d.appspot.com",
    'messagingSenderId': "906402477789",
  };

  ComediansService() {
    final app = initializeApp(
        apiKey: config['apiKey'],
        authDomain: config['authDomain'],
        databaseURL: config['databaseURL'],
        projectId: config['projectId'],
        storageBucket: config['storageBucket'],
        name: 'Debug');

    fs = app.firestore();
  }

  Future<List<Artist>> getArtists() async {
    final artistsSnapshot = await fs
        .collection('artists')
        .where("deleted", "==", false)
        .onSnapshot
        .first;

    return artistsSnapshot.docs
        .map((doc) => new Artist.fromJson(doc.data()))
        .toList();
  }

  Future<Null> deleteArtist(Artist artist) async {
    await fs.collection("artists").doc(artist.id).update(data: {"deleted": true});
  }
}
