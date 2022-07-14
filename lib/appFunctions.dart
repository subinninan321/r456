import 'package:flutter/material.dart';

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

  Widget inputField({
    label,
    obs = false,
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
          obscureText: obs,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black54,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
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