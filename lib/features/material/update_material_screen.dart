import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:se_project/common/components/animated_btn.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/common/constants/utils.dart';
import 'package:se_project/models/repair_material.dart';
import 'package:se_project/services/material_services.dart';

class UpdateMaterialScreen extends StatefulWidget {
  static const String routeName = '/update-material_screen';
  final RepairMaterial material;
  final String? id;
  const UpdateMaterialScreen({super.key, required this.material, required this.id});

  @override
  State<UpdateMaterialScreen> createState() => _UpdateMaterialScreenState();
}

class _UpdateMaterialScreenState extends State<UpdateMaterialScreen> {
  late TextEditingController marqueController = TextEditingController();
  late TextEditingController serieController = TextEditingController();
  late TextEditingController panneController = TextEditingController();
  late TextEditingController traveauxController = TextEditingController();
  late TextEditingController nomClientController = TextEditingController();
  late TextEditingController telephoneController = TextEditingController();
  late TextEditingController reparateurController = TextEditingController();
  late TextEditingController montantController = TextEditingController();
  late TextEditingController dateController = TextEditingController();
  final MaterialServices repairMaterialServices = MaterialServices();
  late RiveAnimationController _btnAnimationColtroller;
  bool isShown = false;
  final _updateMaterialFormKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  List<File> pdfs = [];
  

  @override
  void initState() {
    
    super.initState();
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    marqueController = TextEditingController(text: widget.material.marque);
    serieController = TextEditingController(text: widget.material.serie);
    panneController = TextEditingController(text: widget.material.panne);
    traveauxController = TextEditingController(text: widget.material.traveaux);
    nomClientController = TextEditingController(text: widget.material.nomclient);
    telephoneController = TextEditingController(text: widget.material.telephone);
    reparateurController = TextEditingController(text: widget.material.reparateur);
    montantController = TextEditingController(text: widget.material.montant);
    dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(widget.material.date));
    
    
   
  }

   @override
  void dispose() {
    super.dispose();
    marqueController.dispose();
    serieController.dispose();
    panneController.dispose();
    traveauxController.dispose();
    nomClientController.dispose();
    telephoneController.dispose();
    reparateurController.dispose();
    montantController.dispose();
    dateController.dispose();
  }
  void updateMaterial() async {
    
    if (_updateMaterialFormKey.currentState!.validate() && pdfs.isEmpty){
      var updateddMaterial = RepairMaterial(
        id: widget.id,
        marque: marqueController.text, 
        serie: serieController.text, 
        panne: panneController.text, 
        traveaux: traveauxController.text, 
        nomclient: nomClientController.text, 
        telephone: telephoneController.text, 
        reparateur: reparateurController.text, 
        montant: montantController.text, 
        date: selectedDate, 
        documents: widget.material.documents);
      var id = widget.id;
      repairMaterialServices.updateMaterial(context: context, id: id, updatedMaterial: updateddMaterial);
      }
    else if (_updateMaterialFormKey.currentState!.validate() && pdfs.isNotEmpty) {
      List<String> document = [];


      try {

        final cloudinary = CloudinaryPublic('duenmski3', 'alvvwewb');
        for(int i=0; i<pdfs.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromFile(
          pdfs[i].path, folder: widget.material.serie, resourceType: CloudinaryResourceType.Auto));
        document.add(res.secureUrl);
        }  

      }
      catch (e) {
        throw(Exception);
      }
      var updatedMaterial = RepairMaterial(
        id: widget.id,
        marque: marqueController.text, 
        serie: serieController.text, 
        panne: panneController.text, 
        traveaux: traveauxController.text, 
        nomclient: nomClientController.text, 
        telephone: telephoneController.text, 
        reparateur: reparateurController.text, 
        montant: montantController.text, 
        date: selectedDate, 
        documents: document,);
      var id = widget.id;
      repairMaterialServices.updateMaterial(context: context, id: id, updatedMaterial: updatedMaterial);
      
   }
  }

  Future<void> pickPdfFiles() async {
    List<File> files = await pickPdf();
    setState(() {
      pdfs = files;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Center(
            child: Text(
              'Update Material',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),

          child: Column(        
              children: [
                Row(
                 children: [
                  Container(
                    height: MediaQuery.of(context).size.width *0.1,
                    width:MediaQuery.of(context).size.width *0.1,
                    child: SvgPicture.asset("assets/icons/product.svg"),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text("Please provide the necessary details to add a new material to your inventory. Ensure all fields are accurately filled to keep your records up to date.",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style:  TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: MediaQuery.of(context).size.width > 600 ? FontWeight.bold : FontWeight.normal,
                      
                      color: const Color.fromARGB(255, 41, 44, 46),
                      ),
                    ),
                    
                    ),
                 ],
                ),
                SizedBox(height: 30,),
                Form(
                  key: _updateMaterialFormKey,
                  child: Column(
                    children: [
                       TextFormField(
                      controller: marqueController,
                      decoration: InputDecoration(
                        labelText: "Mark Name",
                        prefixIcon: Icon(Icons.bookmark),
                        border: OutlineInputBorder()
                        ),
                    ),
                      const SizedBox(height: 30),
                      TextFormField(
                      controller: serieController,
                      decoration: InputDecoration(
                        labelText: "Serial Number",
                        prefixIcon: Icon(Icons.numbers),
                        border: OutlineInputBorder()
                        ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: panneController,
                      decoration: InputDecoration(
                        labelText: "Panne",
                        prefixIcon: Icon(Icons.warning),
                        border: OutlineInputBorder()
                        ),
                    ),
                    
                    const SizedBox(height: 30),
                    TextFormField(
                      
                      controller: nomClientController,
                      decoration: InputDecoration(
                        labelText: "Client Name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder()
                        ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      
                      controller: telephoneController,
                      decoration: InputDecoration(
                        labelText: "Mobile Number",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder()
                        ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                     
                      controller: reparateurController,
                      decoration: InputDecoration(
                        labelText: "Name of repairer",
                        prefixIcon: Icon(Icons.handyman),
                        border: OutlineInputBorder()
                        ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      
                      controller: montantController,
                      decoration: InputDecoration(
                        labelText: "Amount",
                        prefixIcon: Icon(Icons.format_list_numbered),
                        border: OutlineInputBorder()
                        ),
                    ),
                    const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                        dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: "Date de repération",
                        prefixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder()
              ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                    TextFormField(
                      maxLines: 2,
                      controller: traveauxController,
                      decoration: InputDecoration(
                        labelText: "Traveaux",
                        prefixIcon: Icon(Icons.build),
                        border: OutlineInputBorder()
                        ),
                    ),
                    ],
                
                  )
                  ),
                
                
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width *0.9,
                  child: FloatingActionButton.extended(
                        heroTag: 'loatingActionButton.extended',
                        icon: const Icon(Icons.picture_as_pdf),
                        onPressed: pickPdfFiles, 
                        label: Text("Select Pdf Documents"),
                                     
                        ),
                ),
                const SizedBox(height: 30),    
                                  
                AnimatedBtn(
                        text: "Update Material",
                        btnAnimationColtroller: _btnAnimationColtroller,
                        press: () {
                          _btnAnimationColtroller.isActive = true;
                          Future.delayed(
                            const Duration(milliseconds: 800),
                            () {
                              
                              setState(() {
                                isShown = true;
                              });
                              // Let's add the slide animation while dialog shows
                              updateMaterial();
                              setState(() {
                                  isShown = false;
                                });
                            },
                          );
                        },
                      ),
                  const SizedBox(height: 30),
            
                
              ],
            ),
          ),
        ),
      
    );
  }
}