import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'comedians_service.dart';
import 'package:comiko_shared/models.dart';

@Component(
  selector: 'comedian',
  styleUrls: const ['comedian_component.css'],
  templateUrl: 'comedian_component.html',
  directives: const [
    CORE_DIRECTIVES,
    formDirectives,
    materialDirectives,
    MaterialRadioComponent,
    MaterialRadioGroupComponent,
  ],
)
class ComedianComponent implements OnInit {
  @Input()
  Artist artist;

  String selectedUrl;
  List<String> imgs;

  final ComediansService comediansService;

  ComedianComponent(this.comediansService);

  @override
  ngOnInit() {
    imgs = [
      r'http://www.envedette.ca/image/policy:1.1550744:1440435284/Jean-Thomas-Jobin.jpg?f=default&$p$f=6b81d5b&1024',
      r'http://www.envedette.ca/image/policy:1.1550744:1440435284/Jean-Thomas-Jobin.jpg?f=default&$p$f=6b81d5b&1024',
      r'http://www.envedette.ca/image/policy:1.1550744:1440435284/Jean-Thomas-Jobin.jpg?f=default&$p$f=6b81d5b&1024',
      r'http://www.envedette.ca/image/policy:1.1550744:1440435284/Jean-Thomas-Jobin.jpg?f=default&$p$f=6b81d5b&1024',
      r'http://www.envedette.ca/image/policy:1.1550744:1440435284/Jean-Thomas-Jobin.jpg?f=default&$p$f=6b81d5b&1024',
    ];
  }

  deleteArtist(event) {
    comediansService.deleteArtist(artist);
  }
}
