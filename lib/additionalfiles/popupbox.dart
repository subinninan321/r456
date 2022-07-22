import 'package:flutter/material.dart';

class PopUpBox extends StatelessWidget {
  const PopUpBox({Key? key}) : super(key: key);


    showEditBox(BuildContext context){
     showDialog(
       context: context,
       builder: (context) => AlertDialog(
               title: const Text("Edit Image"),
               actions: [
                 MaterialButton(onPressed: () {},
                   child: const Text("Pick Form Device"),),
                 MaterialButton(onPressed: () {},
                   child: const Text("Pick Form Device"),)
               ],
             ),
     );
   }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}
