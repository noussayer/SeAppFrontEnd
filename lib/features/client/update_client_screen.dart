import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:se_project/common/components/animated_btn.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/models/client.dart';
import 'package:se_project/services/client_service.dart';

class UpdateClientScreen extends StatefulWidget {
  static const String routeName = '/update-screen-client';
  final Client client;
  final String? id;
  const UpdateClientScreen({super.key, required this.client,required this.id});

  @override
  State<UpdateClientScreen> createState() => _UpdateClientScreenState();
}

class _UpdateClientScreenState extends State<UpdateClientScreen> {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController telephoneController = TextEditingController();
  late TextEditingController adresseController = TextEditingController();
  late TextEditingController codePostalController = TextEditingController();
  late TextEditingController villeController = TextEditingController();
  late TextEditingController cinController = TextEditingController();
  late RiveAnimationController _btnAnimationColtroller;
  bool isShown = false;
  // Other Variables: 
  final ClientService clientService = ClientService();
  final _updateclientFormKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    nameController = TextEditingController(text: widget.client.name);
    telephoneController = TextEditingController(text: widget.client.telephone);
    adresseController = TextEditingController(text: widget.client.adresse);
    codePostalController = TextEditingController(text: widget.client.codepostal);
    villeController = TextEditingController(text: widget.client.ville);
    cinController = TextEditingController(text: widget.client.cin);
   
  }

   @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    telephoneController.dispose();
    adresseController.dispose();
    codePostalController.dispose();
    villeController.dispose();
    cinController.dispose();
    
  }
  void updateClient() async {
    if (_updateclientFormKey.currentState!.validate()){
      var updatedClient = Client(
        id: widget.id,
        name: nameController.text, 
        telephone: telephoneController.text, 
        adresse: adresseController.text, 
        codepostal: codePostalController.text, 
        ville: villeController.text, 
        cin: cinController.text);
      var id = widget.id;
      clientService.updateClient(context: context, id: id, updatedClient: updatedClient);
     
      }
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
              'Update Client',
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
                    child: SvgPicture.asset("assets/icons/client.svg"),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text("Please fill out the following form with the client's information to add a new client to the system. Ensure all required fields are completed accurately to maintain up-to-date and reliable client records",
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
                  key: _updateclientFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder()
                        ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: telephoneController,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder()
                        ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: adresseController,
                      decoration: InputDecoration(
                        labelText: "Adress",
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder()
                        ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: codePostalController,
                      decoration: InputDecoration(
                        labelText: "Postal Code",
                        prefixIcon: Icon(Icons.markunread_mailbox),
                        border: OutlineInputBorder()
                        ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: villeController,
                      decoration: InputDecoration(
                        labelText: "City",
                        prefixIcon: Icon(Icons.location_city),
                        border: OutlineInputBorder()
                        ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: cinController,
                      decoration: InputDecoration(
                        labelText: "CIN",
                        prefixIcon: Icon(Icons.credit_card),
                        border: OutlineInputBorder()
                        ),
                    ),
                    ],
                
                  )
                  ),
                
                
                const SizedBox(height: 30),
                
                                  
                AnimatedBtn(
                        text: "Add Client",
                        btnAnimationColtroller: _btnAnimationColtroller,
                        press: () {
                          _btnAnimationColtroller.isActive = true;
                          Future.delayed(
                            const Duration(milliseconds: 800),
                            () {
                              
                              setState(() {
                                isShown = true;
                              });
                              updateClient();
                              // Let's add the slide animation while dialog shows
                              
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