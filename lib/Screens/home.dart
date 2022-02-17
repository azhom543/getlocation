import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getlocation/GetContollers/home_controller.dart';
import 'package:getlocation/MyWidgets/my_button.dart';
import 'package:getlocation/MyWidgets/my_text.dart';
import 'package:getlocation/constants.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final LocationController c = Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyText(
          text: 'Location picker',
          size: K_fontSizeL,
          color: K_whiteColor,
        ),
        backgroundColor: K_blackColor.withOpacity(0.8),
      ),
      backgroundColor: Colors.white12,
      body: Obx(
        () => Stack(
          children: [
            Image.asset(
              'assets/images/map.jpg',
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ConditionalBuilder(
                    condition: c.isGettingLocation.value,
                    builder: (context) => K_progressIndicator,
                    fallback: (context) => MyButton(
                      borderRadius: K_radius,
                      shadow: 5.0,
                      text: 'Pick my location',
                      fillColor: K_blackColor.withOpacity(0.8),
                      textColor: K_whiteColor,
                      onPressed: () async {
                        c.setChangeGettingLocation(); //To change the location button state from original button to the progress indicator
                        await Geolocator
                            .requestPermission(); //Getting permissons if not set
                        await c
                            .getLatLng(); //To set the new lat lng values depending on location picker
                        c.setChangeGettingLocation(); //To change the location button state from progress indicator to the original button
                        c.setChangeOpenInMaps(); //To show the button of open in maps
                        c.setLatLng();
                      },
                    ),
                  ),
                  K_vSpace20,
                  Row(
                    children: [
                      Expanded(
                          child: TextContainer(text: 'Latitude \n${c.lat}')),
                      K_hSpace20,
                      Expanded(
                          child: TextContainer(text: 'Longitude \n${c.lng}')),
                    ],
                  ),
                  ConditionalBuilder(
                    condition: c.openInMaps.value,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: MyButton(
                        borderRadius: K_radius,
                        shadow: 5.0,
                        text: 'Open in Maps',
                        fillColor: K_blackColor.withOpacity(0.8),
                        textColor: K_whiteColor,
                        onPressed: () async {
                          await MapLauncher.showMarker(
                            coords: Coords(c.lat.value, c.lng.value),
                            title: 'Your location',
                            mapType: MapType.google,
                          );
                        },
                      ),
                    ),
                    fallback: (context) => const Center(),
                  ), //Just show nothing
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextContainer extends StatelessWidget {
  const TextContainer({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(K_radius),
      child: Container(
        color: K_blackColor.withOpacity(0.8),
        height: 70.0,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: MyText(
            text: text,
            size: K_fontSizeM,
            color: K_whiteColor,
          ),
        ),
      ),
    );
  }
}
