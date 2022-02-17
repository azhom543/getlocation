import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LocationController extends GetxController {
  dynamic lat = 0.0.obs;
  dynamic lng = 0.0.obs;
  dynamic isGettingLocation = false.obs;
  dynamic openInMaps = false.obs;
  Position? position;

  getLatLng() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  setLatLng() {
    lat.value = position!.latitude;
    lng.value = position!.longitude;
    update();
  }

  setChangeGettingLocation() {
    isGettingLocation.value = !isGettingLocation.value;
    update();
  }

  setChangeOpenInMaps() {
    openInMaps.value = true;
    update();
  }
}
