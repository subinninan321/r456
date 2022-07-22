import 'package:flutter/material.dart';
import 'package:r456/appFunctions.dart';

class RegCon extends StatefulWidget {
  const RegCon({Key? key}) : super(key: key);

  @override
  State<RegCon> createState() => _RegConState();
}

class _RegConState extends State<RegCon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 24,
          color: Colors.black,
        ),
        title: const Text(
          "Continue Your Registration",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          width: double.infinity,
          // constraints: const BoxConstraints.expand(),
          // decoration: const BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage("assets/img1.jpg"), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 40,
              ),
              const SizedBox(
                height: 4,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(

                  children: <Widget>[
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Driving Licence',
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
                        appFunctions()
                            .inputField(label: 'Name On Driving Licence'),
                        appFunctions().inputField(label: 'Licence No'),
                        appFunctions().inputField(label: 'Valid Till'),
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
                        appFunctions().inputField(label: 'State'),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegCon()));
                    },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Save",
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
}
