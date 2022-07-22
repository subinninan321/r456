import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r456/RegCon.dart';
import 'package:r456/appFunctions.dart';

import 'DriverLogin.dart';

class DriverRegCon extends StatefulWidget
{
  const DriverRegCon({Key? key}) : super(key: key);

  @override
  State<DriverRegCon> createState() => _DriverRegCon();

}
class _DriverRegCon extends State<DriverRegCon>
{
  bool obs=true;
  void _toggleVisibility() {
    setState((){obs = ! obs;});
  }
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
          color: Colors.black,
        ),
        title: const Text("Register As Driver",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
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
              Expanded(child: SingleChildScrollView(

                child: Column(
                  children: <Widget>[
                    appFunctions().inputField(label: 'Name',ctrl: _name),
                    appFunctions().inputField(label: 'Phone No',ctrl: _phone,keyType: TextInputType.phone),
                    appFunctions().inputField(label: 'Email id',ctrl: _email,keyType: TextInputType.emailAddress),
                    inputFieldPassword(label: 'Password',ctrl: _pass1),
                    inputFieldPassword(label: 'Re Enter Password',ctrl: _pass2),

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
                      FirebaseAuth.instance
                      .createUserWithEmailAndPassword(email: _email.text, password: _pass1.text)
                      .then((value){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const RegCon()));
                      }).onError((error, stackTrace) {
                        appFunctions().driverStatus("Successfully Signed Out");
                      });


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

  Widget inputFieldPassword({label,ctrl}) {
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
        TextField(
          controller: ctrl,
          obscureText: obs,
          decoration:  InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black54,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black54,
              ),
            ),
            suffixIcon:GestureDetector(
              onTap: ()=>_toggleVisibility(),
              child: Icon(
                obs?Icons.visibility:Icons.visibility_off,
              ),

            ),
          ),
        ),

        const SizedBox(
          height: 6,
        )
      ],
    );
  }
}