import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:se_project/common/constants/utils.dart';
import 'package:se_project/features/material/update_material_screen.dart';
import 'package:se_project/models/repair_material.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialDetailsScreen extends StatefulWidget {
  static const String routeName ='/material-details';
  final RepairMaterial material;
  const MaterialDetailsScreen({super.key, required this.material,});

  @override
  State<MaterialDetailsScreen> createState() => _MaterialDetailsScreenState();
}

class _MaterialDetailsScreenState extends State<MaterialDetailsScreen> {
  

  void initState() {
    super.initState();
  }
  void openPdfFile(List<String> pdfLink) async {
    if (pdfLink.isEmpty) {
      showSnackBar(context, "There is No PDF");
    }
    else if (await canLaunch(pdfLink[0])){
      await launch(pdfLink[0]);
    }
    else {
      throw 'Could not launch';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
       
        child: SingleChildScrollView(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15,),
              Row(
                children: [
                  Icon(Icons.description),
                  SizedBox(width: 8),
                  Expanded(
                          child: Text("Essential information about the material:",
                      
                        style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                            ),
                ],
              ),
          
             SizedBox(height: 20,),
              
              Card(
                  color: Color(0xFF9CC5FF),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(child: Text(
                                'Product Mark : ',
                                style: TextStyle( fontWeight: FontWeight.bold),
                              ),),
                              Expanded(child: Text(
                                widget.material.marque, // Replace with actual data 
                              ),)
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Flexible(child: Text(
                                'Material Serial Number : ',
                                style: TextStyle( fontWeight: FontWeight.bold),
                                
                              )),
                              Expanded(child: Text(
                                widget.material.serie, // Replace with actual data
                              ),),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Flexible(child: Text(
                                'Outage Reason : ',
                                style: TextStyle( fontWeight: FontWeight.bold),
                              ),),
                              Expanded(child: Text(
                                widget.material.panne, // Replace with actual dat
                              ),)
                            ],
                          ),
                          SizedBox(height: 8,),
                          
                            Row(
                              children: [
                                Flexible(child: Text(
                                  'Nom du Client : ',
                                  style: TextStyle( fontWeight: FontWeight.bold),
                                ),),
                                Expanded(child: Text(
                                  widget.material.nomclient, // Replace with actual data  
                                ),)
                              ],
                            ),
                          
                          
                          SizedBox(height: 8),
                          
                             Row(
                              children: [
                                Flexible(child: Text(
                                  'Phone Number : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),),
                                Expanded(child: Text(
                                  widget.material.telephone, // Replace with actual data
                                ),)
                              ],
                            ),
                          
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Flexible(child: Text(
                                'Repairer\'s Name : ',
                                style: TextStyle( fontWeight: FontWeight.bold),
                              ),),
                              Expanded(child: Text(
                                widget.material.reparateur, // Replace with actual data
                              ),)
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Flexible(child: Text(
                                'Date : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),),
                              Expanded(child: Text(
                                DateFormat('yyyy-MM-dd').format(widget.material.date), // Replace with actual data
                              ),)
                            ],
                          ),
                          
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Flexible(child: Text(
                                'Repair Amount : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),),
                              Expanded(child: Text(
                                widget.material.montant, // Replace with actual data
                              ),)
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                
              
              SizedBox(height: 16),
               Row(
                children: [
                  Icon(Icons.work),
                  SizedBox(width: 8),
                  Expanded(
                          child: Text("Work applied to the equipment:",
                      
                        style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                            ),
                ],
              ),  
          
             SizedBox(height: 16,),
              
              Card(
                color: Color(0xFF9CC5FF),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(widget.material.traveaux, style: TextStyle(fontSize: 19),)
                  
                  ),
              ),
              SizedBox(height: 16,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton.extended(
                      heroTag: "PDF File",
                      onPressed: (){openPdfFile(widget.material.documents);}, 
                      label: Text("PDF File"),
                      icon: Icon(Icons.picture_as_pdf),
                      ),
                      FloatingActionButton.extended(
                        heroTag: "Update",
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: 
                                  (context) => UpdateMaterialScreen(material: widget.material, id: widget.material.id),),);}, 
                      label: Text("Update"),
                      icon: Icon(Icons.edit),
                      ),
          
                    
                    
                  ],
                ),
              
          
              // Repair Information
              
            ],
          ),
          
        ),
      ),
    );
  }
}
