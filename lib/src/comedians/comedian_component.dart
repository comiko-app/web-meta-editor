import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:comiko_shared/models.dart';

import '../google_image_service.dart';
import 'comedians_service.dart';

@Component(
  selector: 'comedian',
  styleUrls: const ['comedian_component.css'],
  templateUrl: 'comedian_component.html',
  directives: const [
    CORE_DIRECTIVES,
    formDirectives,
    materialDirectives,
    materialInputDirectives,
    MaterialInputComponent,
    MaterialRadioComponent,
    MaterialRadioGroupComponent,
  ],
)
class ComedianComponent implements OnInit {
  @Input()
  Artist artist;

  String selectedImageUrl;
  List<String> imgs = [];

  final ComediansService comediansService;

  ComedianComponent(this.comediansService);

  @override
  ngOnInit() {}

  deleteArtist(event) {
    comediansService.deleteArtist(artist);
  }

  updateArtist(event) {
    comediansService.updateArtist(artist);
  }

  Future<Null> showMorePictures() async {
    imgs = await getFirstImageUrlFromGoogleApi(artist.name);
  }

  Future<Null> uploadSelectedImage() async {
    comediansService.updateArtistImage(artist, selectedImageUrl);
  }
}
