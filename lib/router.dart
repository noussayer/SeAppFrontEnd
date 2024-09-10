import 'package:flutter/material.dart';
import 'package:se_project/entry_point.dart';
import 'package:se_project/features/about/about_screen.dart';
import 'package:se_project/features/auth/auth_screen.dart';
import 'package:se_project/features/client/add_client_screen.dart';
import 'package:se_project/features/client/search_client_screen.dart';
import 'package:se_project/features/client/update_client_screen.dart';
import 'package:se_project/features/home/home_screen.dart';
import 'package:se_project/features/material/add_material_screen.dart';
import 'package:se_project/features/material/material_details_screen.dart';
import 'package:se_project/features/material/search_material_screen.dart';
import 'package:se_project/features/material/update_material_screen.dart';
import 'package:se_project/models/client.dart';
import 'package:se_project/models/repair_material.dart';


Route<dynamic> generateRoute (RouteSettings routeSettings) {
  switch(routeSettings.name){
    case AuthScreen.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case AboutScreen.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AboutScreen(),
      );
      
    
    
    case EntryPoint.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EntryPoint(),
      );
  
    case AddMaterialScreen.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddMaterialScreen(),
      );
    case AddClientScreen.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddClientScreen(),
      );
    case SearchMaterialScreen.routeName:
    var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  SearchMaterialScreen(searchQuery: searchQuery),
      );
    case SearchClientScreen.routeName:
    var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  SearchClientScreen(searchQuery: searchQuery),
      );
    case MaterialDetailsScreen.routeName:
    var material = routeSettings.arguments as RepairMaterial;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  MaterialDetailsScreen(material: material),
      );
    
    case UpdateMaterialScreen.routeName:
    var material = routeSettings.arguments as RepairMaterial;
    var id = routeSettings.arguments as String?;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  UpdateMaterialScreen(material: material, id: id),
      );
    case UpdateClientScreen.routeName:
    var client = routeSettings.arguments as Client;
    var id = routeSettings.arguments as String?;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  UpdateClientScreen(client: client, id: id),
      );
    
    
    
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist'),
          ),
        ),
      ); 
  }
}