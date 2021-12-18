import 'package:flutter/material.dart';
import 'package:flutter_snd/domain/controllers/authentications.dart';
import 'package:flutter_snd/domain/controllers/connectivity.dart';
import 'package:flutter_snd/domain/controllers/themecontroller.dart';
import 'package:flutter_snd/ui/pages/content/chat/chat_screen.dart';
import 'package:flutter_snd/ui/pages/content/locations/locations_screen.dart';
import 'package:flutter_snd/ui/pages/content/public_offers/public_offers_screen.dart';
import 'package:flutter_snd/ui/pages/content/publicidad/publicidad_screen.dart';
import 'package:flutter_snd/ui/pages/content/states/states_screen.dart';
import 'package:get/get.dart';

// Widget con el contenido de la aplicacion
class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ControllerAuth controluser = Get.find();
    ThemeController controltema = Get.find();
    ConnectivityController connectivityController =
        Get.find<ConnectivityController>();

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                controltema.selecciontema();
              },
              icon: Obx(
                () => Icon(
                  (controltema.themedark)
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                await controluser.logOut();
                Get.offAllNamed('/auth');
              },
              icon: Icon(Icons.exit_to_app_rounded),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.access_time),
              ),
              Tab(
                icon: Icon(Icons.work),
              ),
              Tab(
                icon: Icon(Icons.gps_fixed),
              ),
              Tab(
                icon: Icon(Icons.chat_bubble),
              ),
            ],
          ),
          title: Text('Red Social'),
        ),
        body: TabBarView(
          children: [
            Obx(
              () => (connectivityController.connected)
                  ? ListaEstados()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
            Obx(
              () => (connectivityController.connected)
                  ? Listapublicidad()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
            Obx(
              () => (connectivityController.connected)
                  ? PublicOffersScreen()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
            Obx(
              () => (connectivityController.connected)
                  ? Locations()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
            Obx(
              () => (connectivityController.connected)
                  ? ListaMensajes()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
