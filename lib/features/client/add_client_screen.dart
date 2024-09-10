import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:se_project/common/components/animated_btn.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/services/client_service.dart';

class AddClientScreen extends StatefulWidget {
  static const String routeName = '/add-client';
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController codePostalController = TextEditingController();
  final TextEditingController villeController = TextEditingController();
  final TextEditingController cinController = TextEditingController();
  late RiveAnimationController _btnAnimationColtroller;
  bool isShown = false;

  // other vars:
  final ClientService clientService = ClientService();
  final _addclientFormKey = GlobalKey<FormState>();
  
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
    nameController.dispose();
    telephoneController.dispose();
    adresseController.dispose();
    codePostalController.dispose();
    villeController.dispose();
    cinController.dispose();
    
  }
  void addClent(){
    if (_addclientFormKey.currentState!.validate()){
      clientService.addClient(
        context: context, 
        name: nameController.text, 
        telephone: telephoneController.text, 
        adresse: adresseController.text, 
        codepostal: codePostalController.text, 
        ville: villeController.text, 
        cin: cinController.text);
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
              'Add Client',
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
                  key: _addclientFormKey,
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
                              addClent();
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