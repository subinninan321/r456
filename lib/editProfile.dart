import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:r456/databaseoperations.dart';
import 'appFunctions.dart';
import 'dashboard.dart';

class editProfile extends StatefulWidget {

  const editProfile({
    Key? key,
    //required this.imagePath,
    //required this.onClicked,
  }) : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {




  Widget buildImage(){
    const img=AssetImage('assets/img1.jpg');
    return Material(
      color: Colors.transparent,
        child: Ink.image(
          image: img,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
          child: InkWell(onTap: (){},),
        ),
    );
  }

  Widget editIcon() {
    return buildShapeCircle(
      all: 3,
      color: Colors.white,
      child: buildShapeCircle(
        color:Colors.lightBlueAccent,
        all: 8,
        child: const Icon(
          Icons.edit,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildShapeCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );




  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    //editprof

    String driverName='';
    String driverEmail='';
    String driverPhone='';


    TextEditingController _nameOnLicence = TextEditingController();
    TextEditingController _licenceNumber = TextEditingController();
    TextEditingController _vehicleNumber = TextEditingController();
    TextEditingController _state = TextEditingController();
    TextEditingController _district = TextEditingController();
    TextEditingController _locality = TextEditingController();
    TextEditingController _vehicleModel = TextEditingController();
    TextEditingController _v = TextEditingController();


    //textfield


    Widget editableField({
      label,
      ctrl,
      hint="",
      keyType =TextInputType.text,
      obst = false,
      editing=false,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          TextFormField(
            readOnly: editing,
            focusNode: FocusNode(),
            controller: ctrl,
            obscureText: obst,
            decoration:  InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder:OutlineInputBorder(
                borderRadius:BorderRadius.circular(10) ,
                borderSide:const  BorderSide(
                  color:Colors.black54,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius:BorderRadius.circular(10) ,
                borderSide:const  BorderSide(
                  color:Colors.black54,
                ),
              ),
              suffixIcon:GestureDetector(
                child: const Icon(
                  Icons.edit,
                ),
                onTap: ()=>{
                  setState((){
                    editing=!editing;
                  }),
                },
              ),
            ),
            // validator: (value){
            //   if(reenter && _pass1.text.trim()!= value){
            //     passMatch=false;
            //     return "Password doesn't match";
            //   }else if (value != null && value.length < 8 && value.isNotEmpty) {
            //     return "Minimum 8 characters required";
            //   }else if (reenter && _pass1.text.trim()== value) {
            //     passMatch=true;
            //     return null;
            //   } else {
            //     return null;
            //   }
            //
            // },
          ),

          const SizedBox(
            height: 6,
          )
        ],
      );
    }


    //textfield


    Widget showProfile(){
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        width: double.infinity,
        // constraints: const BoxConstraints.expand(),
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage("assets/img1.jpg"), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 40,
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          Center(
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(

                                      child: buildImage(),

                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 4,
                                    child: GestureDetector (
                                      //onTap: const PopUpBox().showEditBox(context),
                                      child: editIcon(),
                                    ),
                                  )
                                ],
                              )
                          ),
                          const SizedBox(height: 25),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Personal Details',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          editableField(label: 'Name',ctrl: _nameOnLicence),
                          //editableField(label: 'Email',ctrl: userEmailID),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Region Information',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          editableField(label: 'State',ctrl: _licenceNumber),
                          appFunctions().inputField(label: 'District'),
                          appFunctions().inputField(label: 'Locality'),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),Column(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Vehicle Information',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          appFunctions().inputField(label: 'Vehicle Number'),
                          appFunctions().inputField(label: 'Vehicle Model'),
                          appFunctions().inputField(label: 'Valid Till'),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                )),
            Column(
              children: <Widget>[
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    appFunctions().driverStatus("Profile Updated");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const dashboard()));
                  },
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    
    //editprof



    

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 24,
          color: Colors.white,
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
            .collection('driverdetails')
            .doc(userEmailID)
            .snapshots(),
        builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');

            if (snapshot.hasData) {
              var output = snapshot.data!.data();
              _nameOnLicence = TextEditingController(text: output!['name']);
              _licenceNumber = TextEditingController(text: output['phone']);
              _district = TextEditingController(text: output['phone']);
              _state = TextEditingController(text: output['phone']);
              _vehicleModel = TextEditingController(text: output['phone']);
              _locality= TextEditingController(text: output['Locality']);
              return showProfile();
            }

            return const Center(child: CircularProgressIndicator());
          },
        )
      ),
    );
  }
}


