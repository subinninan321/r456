import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class appFunctions {

  void main() {
    print(calculateFare(4));
  }

  calculateFare(distance) {
    if (distance > 3) {
      return 30 + ((distance - 3) * 8);
    } else {
      return 30;
    }
  }
  void driverStatus(String status)
  {
    Fluttertoast.showToast(msg: status,fontSize: 16);
  }



  //for input fields

  Widget inputField({
    label,
    ctrl,
    hint="",
    keyType =TextInputType.text,
    obst = false,
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
        TextField(
          obscureText: obst,
          keyboardType: keyType,
          controller: ctrl,
          decoration:InputDecoration(
            hintText: hint,
            contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 10),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:const BorderSide(
                color: Colors.black54,
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