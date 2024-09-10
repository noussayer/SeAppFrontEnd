import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:se_project/common/components/animated_btn.dart';
import 'package:se_project/common/components/loader.dart';
import 'package:se_project/common/components/material_card.dart';
import 'package:se_project/common/constants/global_variables.dart';
import 'package:se_project/common/constants/utils.dart';
import 'package:se_project/features/material/add_material_screen.dart';
import 'package:se_project/features/material/material_details_screen.dart';
import 'package:se_project/features/material/search_material_screen.dart';
import 'package:se_project/models/repair_material.dart';
import 'package:se_project/services/material_services.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialPostsScreen extends StatefulWidget {
  const MaterialPostsScreen({super.key});

  @override
  State<MaterialPostsScreen> createState() => _MaterialPostsScreenState();
}

class _MaterialPostsScreenState extends State<MaterialPostsScreen> {
  List<RepairMaterial>? materials;
  final MaterialServices repairMaterialServices = MaterialServices();
  late RiveAnimationController _btnAnimationColtroller;
  bool isShown = false;


  @override
  void initState() {
    super.initState();
    fetchAllMaterials();
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  fetchAllMaterials() async {
    materials= await repairMaterialServices.fetchAllmaterials(context);
    setState(() {
      
    });
  }
  void deleteMaterial(RepairMaterial material, int index) {
    repairMaterialServices.deleteProduct(
      context: context, 
      material: material, 
      onSuccess: () {
        materials!.removeAt(index);
        setState(() {});
      });
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
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchMaterialScreen.routeName, arguments: query);
  }
  @override
  Widget build(BuildContext context) {
    return  materials == null
    ? const loader()
    : Scaffold( 
      appBar: PreferredSize(
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
                margin: EdgeInsets.only(left: 50, top: 15),
                child: Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 1,
                  child: Padding(
                    padding: EdgeInsets.zero,
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
                  "All Materials",
                  style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
                  
                
                ),
              ),
              ...materials!.asMap().entries.map(
                (entry) => GestureDetector(
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: 
                  (context) => MaterialDetailsScreen(material: entry.value),),);},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: MaterialCard(
                      material: entry.value, 
                      onDelete: () { deleteMaterial(entry.value, entry.key); }, 
                      openPdf: () {openPdfFile(entry.value.documents);},),
                      
                      ),
                    ),
                    ),
                    
        
        
            Center(
              child: AnimatedBtn(
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
                              Navigator.pushNamed(context, AddMaterialScreen.routeName);
                              // Let's add the slide animation while dialog shows
                              
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


