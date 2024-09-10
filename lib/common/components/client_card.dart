import 'package:flutter/material.dart';
import 'package:se_project/models/client.dart';

class ClientCard extends StatelessWidget {
  final Client client;
  final VoidCallback? onDelete;
  final VoidCallback? openPdf; 
  

  ClientCard({
    required this.client, this.onDelete, this.openPdf,
    
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xFF9CC5FF),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                client.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 10),
                  Text(client.telephone),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 10),
                  Text(client.adresse),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.code),
                  SizedBox(width: 10),
                  Text(client.codepostal),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.location_city),
                  SizedBox(width: 10),
                  Text(client.ville),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.perm_identity),
                  SizedBox(width: 10),
                  Text(client.cin),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                    heroTag: "delete",
                    onPressed: onDelete, 
                    label: Text("Delete"),
                    icon: Icon(Icons.delete),
                    ),
                    FloatingActionButton.extended(
                      heroTag: "uodate",
                    onPressed: openPdf, 
                    label: Text("Update"),
                    icon: Icon(Icons.edit),
                    ),

                  
                  
                ],
              ),
            ],
          ),
        ),
      
    );
  }
}