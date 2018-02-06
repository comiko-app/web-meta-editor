import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:comedian_images_selector/services.dart';
import 'package:comiko_shared/models.dart';

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
class ComedianComponent {
  @Input()
  Artist artist;

  String radioSelectedUrl;
  String imageUrlTextboxValue;
  List<String> imgs = [];

  final ComediansService comediansService;

  ComedianComponent(this.comediansService);

  deleteArtist(event) {
    comediansService.deleteArtist(artist);
  }

  updateArtist(event) {
    artist.imageUrl = radioSelectedUrl;

    comediansService.updateArtist(artist);
  }

  Future<Null> showMorePictures() async {
    imgs = await getFirstImageUrlFromGoogleApi(artist.name);
  }

  Future<Null> uploadSelectedImage() {
    return comediansService.updateArtistImage(artist, imageUrlTextboxValue);
  }

  void updateUrlTextbox() {
    imageUrlTextboxValue = radioSelectedUrl;
  }
}
