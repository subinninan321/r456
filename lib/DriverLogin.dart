import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r456/DriverRegCon.dart';
import 'package:r456/appFunctions.dart';
import 'package:r456/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';

class DriverLogin extends StatefulWidget {
  const DriverLogin({Key? key}) : super(key: key);

  @override
  State<DriverLogin> createState() => _DriverLoginState();
}

class _DriverLoginState extends State<DriverLogin> {
  bool obs =true;
  _toggleVisibility() {
    setState((){obs = ! obs;});
  }
  //for login
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("usernot found");
      }
    }
    return user;
  }

  //login

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    //controllers
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    //controllers

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          width: double.infinity,
          // height: 400,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                appFunctions().inputField(label: "Username",ctrl: _emailController,keyType: TextInputType.emailAddress),
                inputFieldPassword(label: "Password",ctrl: _passwordController),

                MaterialButton(
                    onPressed: () async {
                      User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                      print(user);
                      if(user!=null){
                        Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const dashboard()));
                  }

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
