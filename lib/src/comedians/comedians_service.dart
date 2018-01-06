// Copyright (c) 2017, Joel Trottier-Hebert. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/core.dart';
import 'package:comiko_shared/models.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:http/browser_client.dart';

@Injectable()
class ComediansService {
  Firestore fs;
  Storage storage;

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
    storage = app.storage();
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

  Stream<Artist> getArtistsAsStream() async* {
    final artistsSnapshot =
        await fs.collection('artists').where("deleted", "==", false).onSnapshot;

    await for (final changes in artistsSnapshot) {
      for (final change in changes.docChanges) {
        var artist = new Artist.fromJson(change.doc.data());

        if (change.type == 'removed') {
          artist.deleted = true;
        }

        yield artist;
      }
    }
  }

  Future<Null> deleteArtist(Artist artist) async {
    await fs
        .collection("artists")
        .doc(artist.id)
        .update(data: {"deleted": true});
  }

  Future<Null> updateArtist(Artist artist) async {
    await fs.collection("artists").doc(artist.id).update(data: artist.toJson());
  }

  Future<Null> updateArtistImage(Artist artist, String selectedImageUrl) async {
    final client = new BrowserClient();
    final response = await client
        .get('https://cors-anywhere.herokuapp.com/$selectedImageUrl');
    final imageData = response.bodyBytes;

    final fileExtension = selectedImageUrl.split(".").last;

    try {
      final uploadResult = await storage
          .ref("photos")
          .child('${artist.name}.$fileExtension')
          .put(imageData,
              new UploadMetadata(contentType: 'image/$fileExtension'))
          .future;

      final uploadedUrl = uploadResult.downloadURL;
      artist.imageUrl = uploadedUrl.toString();
      updateArtist(artist);
    } catch (e) {
      print(e);
    }
  }
}
