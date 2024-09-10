import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:se_project/common/constants/error_handling.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/common/constants/utils.dart';
import 'package:se_project/models/repair_material.dart';
import 'package:se_project/providers/user_provider.dart';

class MaterialServices {
  void addMaterial({
    required BuildContext context,
    required String marque,
    required String serie,
    required String panne,
    required String traveaux,
    required String nomclient,
    required String telephone,
    required String reparateur,
    required String montant,
    required DateTime date,
    required List<File> documents,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('duenmski3', 'alvvwewb');
      List<String> documentUrls = [];
      for(int i=0; i<documents.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromFile(documents[i].path, folder: serie, resourceType: CloudinaryResourceType.Auto));
        documentUrls.add(res.secureUrl);
      }
      RepairMaterial repairMaterial = RepairMaterial(
        marque: marque, 
        serie: serie, 
        panne: panne, 
        traveaux: traveaux, 
        nomclient: nomclient, 
        telephone: telephone, 
        reparateur: reparateur, 
        montant: montant, 
        date: date, 
        documents: documentUrls);
      

        http.Response res = await http.post(
          Uri.parse('$uri/api/add-material'), 
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
            },
          body: repairMaterial.toJson(),
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess:() { 
            showSnackBar(context, 'Product Added successfully');
          },
          );

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get All materials:
  Future<List<RepairMaterial>> fetchAllmaterials(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<RepairMaterial> materialList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-materials'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess: () {
            for( int i=0; i<jsonDecode(res.body).length; i++) {
              materialList.add(
                RepairMaterial.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                    ),
                    ),

              );
            }
          }
        );
    } catch(e) {
      showSnackBar(context, e.toString());
    }
    return materialList;
  }
  

 // delete material:
 void deleteProduct({
    required BuildContext context, 
    required RepairMaterial material, 
    required VoidCallback onSuccess
    }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
        http.Response res = await http.post(
          Uri.parse('$uri/api/delete-material'), 
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
            },
          body: jsonEncode({
            'id': material.id,
          }),
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess:() { 
            onSuccess();
          },
          );

    } catch (e) {
      showSnackBar(context, e.toString());
    }

    }
    // update Product:
void updateMaterial({
    required BuildContext context,
    required String? id,
    required RepairMaterial updatedMaterial, 
    }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
        http.Response res = await http.put(
          Uri.parse('$uri/api/update-material/$id'), 
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
            
            },
          body: jsonEncode(updatedMaterial.toMap()).toString(),
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess:() { 
            showSnackBar(context, 'Material updated successfully');
          },);
           

    } catch (e) {
      showSnackBar(context, e.toString());
    }

    }

    // Search material: 
  Future<List<RepairMaterial>> fetchSearchedMaterial({
    required BuildContext context, 
    required String searchQuery
    }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<RepairMaterial> materials = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/search-material/$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess: () {
            for( int i=0; i<jsonDecode(res.body).length; i++) {
              materials.add(
                RepairMaterial.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                    ),
                    ),

              );
            }
          }
        );
    } catch(e) {
      showSnackBar(context, e.toString());
    }
    return materials;

  }
}