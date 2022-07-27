import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r456/DriverRegCon.dart';
import 'package:r456/appFunctions.dart';
import 'package:r456/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:r456/databaseoperations.dart';

class DriverLogin extends StatefulWidget {



  //final Function(User) onLogin;

  const DriverLogin({Key? key}) : super(key: key);

  @override
  State<DriverLogin> createState() => _DriverLoginState();
}

class _DriverLoginState extends State<DriverLogin> {
  bool obs =true;
  _toggleVisibility() {
    setState((){obs = ! obs;});
  }

  //controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //controllers
  //login

  final appBar = AppBar(
    automaticallyImplyLeading: false,
    title: const Text(
      "Login",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final scrnHeight =queryData.size.height;
    final barHeight =appBar.preferredSize.height;
    final stbarHeight=queryData.padding.top;
    final conHeight=(scrnHeight-barHeight-stbarHeight);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
      appBar: appBar,

      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          width: double.infinity,
          // height: 400,

            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView( //col
                padding: EdgeInsets.only(top: (conHeight/4),),
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  appFunctions().inputField(label: "Email",ctrl: _emailController,keyType: TextInputType.emailAddress,hint: "Email"),
                  inputFieldPassword(label: "Password",ctrl: _passwordController),

                  MaterialButton(
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        context.read<Authentication>().signIn(email: _emailController.text.trim(), password: _passwordController.text.trim());


                      },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minWidth: queryData.size.width*0.8,
                    height: 50,
                      color: Colors.blue.shade400,
                      elevation: 5,

                      child:const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      const Text(
                        "Don't have an Account? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => const DriverRegCon())),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

        ),
      ),
    ),);
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
          if(value!=null && value.length<8 && value.isNotEmpty){
            return "Minimum 8 characters required";
          }
          else
            {
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
