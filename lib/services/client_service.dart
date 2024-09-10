import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/common/constants/error_handling.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/common/constants/utils.dart';
import 'package:se_project/models/client.dart';
import 'package:http/http.dart' as http;
import 'package:se_project/providers/user_provider.dart';


class ClientService {
  void addClient({
    required BuildContext context,
    required String name,
    required String telephone,
    required String adresse,
    required String codepostal,
    required String ville,
    required String cin,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      Client product = Client(
        name: name, 
        telephone: telephone, 
        adresse: adresse, 
        codepostal: codepostal, 
        ville: ville, 
        cin: cin);

        http.Response res = await http.post(
          Uri.parse('$uri/api/add-client'), 
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
            },
          body: product.toJson(),
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess:() { 
            showSnackBar(context, 'Client Added successfully');
          },
          );

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get all the clients:
  Future<List<Client>> fetchAllClients(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Client> clientList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-clients'),
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
              clientList.add(
                Client.fromJson(
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
    return clientList;
  }

  // Delete Client:

  void deleteClient({
    required BuildContext context, 
    required Client client, 
    required VoidCallback onSuccess
    }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
        http.Response res = await http.post(
          Uri.parse('$uri/api/delete-client'), 
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
            },
          body: jsonEncode({
            'id': client.id,
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
    // update client:

  void updateClient({
    required BuildContext context,
    required String? id,
    required Client updatedClient, 
    }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
        http.Response res = await http.put(
          Uri.parse('$uri/api/update-client/$id'), 
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
            
            },
          body: jsonEncode(updatedClient.toMap()).toString(),
        );
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess:() { 
            showSnackBar(context, 'Client updated successfully');
          },);
           

    } catch (e) {
      showSnackBar(context, e.toString());
    }

    }
    // Search Client:
    Future<List<Client>> fetchSearchedClient({
    required BuildContext context, 
    required String searchQuery
    }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Client> clients = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/search-client/$searchQuery'),
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
              clients.add(
                Client.fromJson(
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
    return clients;

  }
}