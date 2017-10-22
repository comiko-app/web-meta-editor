// Copyright (c) 2017, Joel Trottier-Hebert. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/core.dart';
import 'package:comiko_shared/models.dart';

@Injectable()
class ComediansService {
  List<Artist> artists = [
    new Artist(
        name: 'Jean-Thomas Jobin',
        bio: 'Biographie texte',
        imageUrl:
            'https://pbs.twimg.com/profile_images/600462018978652160/gjyZypDC.jpg',
        website: 'www.jeanthomasjobin.com',
        facebook: 'https://www.facebook.com/JeanThomasJobin',
        twitter: 'https://twitter.com/JeanThomasJobin',
        youtube: 'https://www.youtube.com/user/JeanThomasJobin',
        id: '38120938209'),
    new Artist(
        name: 'Jean-Thomas Jobin',
        bio: 'Biographie texte',
        imageUrl:
            'https://pbs.twimg.com/profile_images/600462018978652160/gjyZypDC.jpg',
        website: 'www.jeanthomasjobin.com',
        facebook: 'https://www.facebook.com/JeanThomasJobin',
        twitter: 'https://twitter.com/JeanThomasJobin',
        youtube: 'https://www.youtube.com/user/JeanThomasJobin',
        id: '38120938209'),
  ];

  Future<List<Artist>> getComedians() async => artists;
}
