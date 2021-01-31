import 'package:flutter/material.dart';
import 'package:login_firebase/components/custome_drawer_profile.dart';
import 'package:login_firebase/components/drawer_title.dart';

class DrawerComponents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                colors: [
                  Color.fromARGB(255, 203, 236, 241),
                  Colors.white,
                ],
              ),
            ),
          ),
          ListView(
            children: [
              CustomeDrawerProfile(),
              Divider(),
              DrawerTitle(
                iconData: Icons.home,
                title: 'Inicio',
                page: 0,
              ),
              DrawerTitle(
                iconData: Icons.list,
                title: 'Productos',
                page: 1,
              ),
              DrawerTitle(
                  iconData: Icons.playlist_add_check,
                  title: 'Meus Pedidos',
                  page: 2),
              DrawerTitle(
                iconData: Icons.location_on,
                title: 'Lojas',
                page: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
