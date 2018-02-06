// Copyright (c) 2017, Joel Trottier-Hebert. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:angular/core.dart';
import 'package:comedian_images_selector/services.dart';
import 'package:comiko_shared/models.dart';
import 'package:firebase/firebase.dart';
import 'package:http/browser_client.dart';

@Injectable()
class ComediansService {
  final FirebaseService firebaseService;

  ComediansService(this.firebaseService);

  Future<List<Artist>> getArtists() async {
    final artistsSnapshot = await firebaseService.fs
        .collection('artists')
        .where("deleted", "==", false)
        .onSnapshot
        .first;

    return artistsSnapshot.docs
        .map((doc) => new Artist.fromJson(doc.data()))
        .toList();
  }

  Stream<Artist> getArtistsAsStream() async* {
    final artistsSnapshot = await firebaseService.fs
        .collection('artists')
        .where("deleted", "==", false)
        .onSnapshot;

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
    await firebaseService.fs
        .collection("artists")
        .doc(artist.id)
        .update(data: {"deleted": true});
  }

  Future<Null> updateArtist(Artist artist) {
    return firebaseService.fs
        .collection("artists")
        .doc(artist.id)
        .update(data: artist.toJson());
  }

  Future<Null> clearAllImages() async {
    var artists = await getArtists();

    final batch = firebaseService.fs.batch();

    for (var a in artists) {
      a.imageUrl = null;

      final ref = firebaseService.fs.collection("artists").doc(a.id);
      batch.update(ref, data: a.toJson());
    }

    await batch.commit();

    await firebaseService.storage.ref('photos').delete();
  }

  Future<Null> updateArtistImage(Artist artist, String selectedImageUrl,
      {String extension}) async {
    final client = new BrowserClient();
    final response = await client
        .get('https://cors-anywhere.herokuapp.com/$selectedImageUrl');

    if (response.statusCode != 200) {
      throw "Oops, can't use cors-anywhere for ${artist.name} -- ${artist
          .imageUrl}";
    }

    final imageData = response.bodyBytes;

    if (extension == null) {
      extension = selectedImageUrl.split(".").last;
    }

    try {
      final uploadResult = await firebaseService.storage
          .ref("photos")
          .child('${artist.name}.$extension')
          .put(imageData, new UploadMetadata(contentType: 'image/$extension'))
          .future;

      final uploadedUrl = uploadResult.downloadURL;
      artist.imageUrl = uploadedUrl.toString();
      await updateArtist(artist);
    } catch (e) {
      print(e);
    }
  }

  Future<Null> optimizeImages() async {
    final artists = await getArtists();

    final toOptimize = artists
        .where((Artist a) => a.imageUrl != null)
        .map((Artist a) => {'id': a.id, 'url': a.imageUrl})
        .toList();

    final client = new BrowserClient();
    final encode = JSON.encode(toOptimize);
    print(encode);
    try {
      final response = await client.post(
          'https://us-central1-comiko-3916d.cloudfunctions.net/optimizeImages',
          headers: {'content-type': 'application/json'},
          body: encode);

      List<Map<String, dynamic>> optimizedImages = JSON.decode(response.body);

      for (final image in optimizedImages) {
        final artist = artists.firstWhere(
          (Artist a) => a.id == image['id'],
          orElse: () => null,
        );

        if (artist == null) {
          print("Couldn't find id ${image['id']}");
          continue;
        }

        final url = image['url'];
        final initialExtension =
            artist.imageUrl.split('.').last.split('?').first;

        await updateArtistImage(artist, url, extension: initialExtension);
      }
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }
}
