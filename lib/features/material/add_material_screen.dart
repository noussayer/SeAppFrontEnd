import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:se_project/common/components/animated_btn.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/common/constants/utils.dart';
import 'package:se_project/services/material_services.dart';

class AddMaterialScreen extends StatefulWidget {
  static const String routeName = '/add-material';
  const AddMaterialScreen({super.key});

  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}

class _AddMaterialScreenState extends State<AddMaterialScreen> {
  final TextEditingController marqueController = TextEditingController();
  final TextEditingController serieController = TextEditingController();
  final TextEditingController panneController = TextEditingController();
  final TextEditingController traveauxController = TextEditingController();
  final TextEditingController nomClientController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController reparateurController = TextEditingController();
  final TextEditingController montantController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final MaterialServices repairMaterialServices = MaterialServices();
  late RiveAnimationController _btnAnimationColtroller;
  bool isShown = false;

  // Other var:
  DateTime selectedDate = DateTime.now();
  List<File> documents = [];
  List<String> pdfs = [];
  final _addMaterialFormKey = GlobalKey<FormState>();



   @override
  void initState() {
    super.initState();
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
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
   void addRepairMaterial() {
    if (_addMaterialFormKey.currentState!.validate()) {
      repairMaterialServices.addMaterial(
        context: context, 
        marque: marqueController.text, 
        serie: serieController.text, 
        panne: panneController.text, 
        traveaux: traveauxController.text, 
        nomclient: nomClientController.text, 
        telephone: telephoneController.text, 
        reparateur: reparateurController.text, 
        montant: montantController.text, 
        date: selectedDate, 
        documents: documents);

      }
  }
  Future<void> pickPdfFiles() async {
    List<File> files = await pickPdf();
    setState(() {
      documents = files;
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
              'Add Material',
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
                  key: _addMaterialFormKey,
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
                        text: "Add Material",
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
                              addRepairMaterial();
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