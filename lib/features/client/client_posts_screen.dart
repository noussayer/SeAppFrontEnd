import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:se_project/common/components/animated_btn.dart';
import 'package:se_project/common/components/client_card.dart';
import 'package:se_project/common/components/loader.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/features/client/add_client_screen.dart';
import 'package:se_project/features/client/search_client_screen.dart';
import 'package:se_project/features/client/update_client_screen.dart';
import 'package:se_project/models/client.dart';
import 'package:se_project/services/client_service.dart';

class ClientPostsScreen extends StatefulWidget {
  const ClientPostsScreen({super.key});

  @override
  State<ClientPostsScreen> createState() => _ClientPostsScreenState();
}

class _ClientPostsScreenState extends State<ClientPostsScreen> {
  List<Client>? clients;
  final ClientService clientService = ClientService();
  late RiveAnimationController _btnAnimationColtroller;
  bool isShown = false;

  @override
  void initState() {
    super.initState();
    fetchAllClients();
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  fetchAllClients() async {
    clients= await clientService.fetchAllClients(context);
    setState(() {
    });
  }
  void deleteClient(Client client, int index) {
    clientService.deleteClient(
      context: context, 
      client: client, 
      onSuccess: () {
        clients!.removeAt(index);
        setState(() {});
      },);
  }
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchClientScreen.routeName, arguments: query);
  }
  @override
  Widget build(BuildContext context) {
    return clients == null
    ? const loader()
    : Scaffold(
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                height: 42,
                margin: EdgeInsets.only( top: 15),
                child: Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 1,
                  child: TextFormField(
                    onFieldSubmitted: navigateToSearchScreen,
                    decoration: InputDecoration(
                      prefixIcon: InkWell(
                        onTap: (){},
                        child: const Padding(
                          padding: EdgeInsets.only(left: 6,),
                          child: Icon(Icons.search, color: Colors.black, size: 23,),

                          ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(top: 10),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                    ),
                  ),
                  
                  ),
                            ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),

              )
           

            ],
            
          ),
        ),

      ),
      
        body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "All Clients",
                  style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
                  
                
                ),
              ),
              ...clients!.asMap().entries.map(
                (entry) => Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: ClientCard(
                      client: entry.value, 
                      onDelete: () {deleteClient(entry.value, entry.key);},
                      openPdf: () {  Navigator.push(context, MaterialPageRoute(builder: 
                                (context) => UpdateClientScreen(client: entry.value, id: entry.value.id),));
  },
                    
                    ),
                    ),
                    ),
                    
            Center(
              child: AnimatedBtn(
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
                              // Let's add the slide animation while dialog shows
                              Navigator.pushNamed(context, AddClientScreen.routeName);
                              setState(() {
                                  isShown = false;
                                });
                            },
                          );
                        },
                      ),
            ),
            SizedBox(height: 30,),
                    
             
            ],
          ),
        ),
      ),
      
    );
  }
}