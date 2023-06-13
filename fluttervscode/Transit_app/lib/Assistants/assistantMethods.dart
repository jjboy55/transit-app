import 'package:geolocator/geolocator.dart';
import 'package:transit_app/Assistants/requestassistant.dart';

class AssistantMethods {
  static Future<dynamic> searchCoordinateAddress(Position position) async {
    String placeAddress = '';
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyCvvCgQnhhSOZRw0qQa0DSixylV_GeGURY';

    var response = await RequestAssistant.getRequest(url);

    if (response != 'failed') {
      placeAddress = response['results'][0]['formatted_address'];
      return placeAddress;
    }
  }
}
