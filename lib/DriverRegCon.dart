import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r456/RegCon.dart';
import 'package:r456/appFunctions.dart';
import 'package:r456/databaseoperations.dart';

import 'DriverLogin.dart';
import 'dashboard.dart';

class DriverRegCon extends StatefulWidget
{
  const DriverRegCon({Key? key}) : super(key: key);

  @override
  State<DriverRegCon> createState() => _DriverRegCon();

}
class _DriverRegCon extends State<DriverRegCon>
{
  bool obs=true;
  bool passMatch=false;
  void _toggleVisibility() {
    setState((){obs = ! obs;});
  }
  final formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass1 = TextEditingController();
  final TextEditingController _pass2 = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
           Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 24,
          color: Colors.white,
        ),
        title: const Text("Register As Driver",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget>[
              Container(
                height: 40,
              ),
              Expanded(child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    appFunctions().inputField(label: 'Name',ctrl: _name),
                    appFunctions().inputField(label: 'Phone No',ctrl: _phone,keyType: TextInputType.phone),
                    appFunctions().inputField(label: 'Email id',ctrl: _email,keyType: TextInputType.emailAddress),
                    inputFieldPassword(label: 'Password',ctrl: _pass1),
                    inputFieldPassword(label: 'Re Enter Password',ctrl: _pass2,reenter: true),

                  ],
                ),
              )
              ),


              Column (
                children:   <Widget>[

                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,

                    onPressed: () {
                      final isValidForm = formKey.currentState!.validate();
                      if(passMatch && isValidForm){
                        try{
                        context.read<Authentication>().signUp(
                            email: _email.text.trim(),
                            password: _pass1.text.trim(),
                            name: _name.text.trim(),
                            phone: _phone.text.trim());
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const RegCon()));}
                            catch(e){
                          print(e);
                            }
                      } else {
                        appFunctions().driverStatus("Check your password");
                      }

                    },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(

                      "Sign Up",
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





        ),
      ),
    );

  }

  Widget inputFieldPassword({label,ctrl,reenter = false}) {
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
          controller: ctrl,
          obscureText: obs,
          decoration:  InputDecoration(
            hintText: "Password",
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
              onTap: ()=>_toggleVisibility(),
              child: Icon(
                obs?Icons.visibility:Icons.visibility_off,
              ),

            ),
          ),
          validator: (value){
            if(reenter && _pass1.text.trim()!= value){
              passMatch=false;
              return "Password doesn't match";
            }else if (value != null && value.length < 8 && value.isNotEmpty) {
              return "Minimum 8 characters required";
            }else if (reenter && _pass1.text.trim()== value) {
              passMatch=true;
              return null;
            } else {
              return null;
            }

          },
        ),

        const SizedBox(
          height: 6,
        )
      ],
    );

  }
}