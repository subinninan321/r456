import 'package:flutter/material.dart';
import 'package:r456/appFunctions.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          width: double.infinity,
          // height: 400,

            child: Column(
              children: <Widget>[
                appFunctions().inputField(label: "Username"),
                inputFieldPassword(label: "Password"),
              ],
            ),

        ),
      ),
    );
  }


Widget inputFieldPassword({label}) {
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
