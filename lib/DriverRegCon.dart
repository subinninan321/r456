import 'package:flutter/material.dart';
import 'package:r456/RegCon.dart';
import 'package:r456/appFunctions.dart';

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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
           // Navigator.pop(context);
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
                    appFunctions().inputField(label: 'Name'),
                    appFunctions().inputField(label: 'Phone No'),
                    appFunctions().inputField(label: 'Email id'),
                    appFunctions().inputField(label: 'Date of Birth'),
                    inputFieldPassword(label: 'Password'),
                    inputFieldPassword(label: 'Re Enter Password'),

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
                      Navigator.push(context,MaterialPageRoute(builder: (context) => const RegCon()));
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