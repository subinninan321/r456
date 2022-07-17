import 'package:flutter/material.dart';
import 'package:r456/DriverRegCon.dart';
import 'package:r456/HistoryPage.dart';
import 'package:r456/NavPanel.dart';
import 'package:r456/appFunctions.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  bool value = false;
  @override
  // void initState(){
  //   print('inti');
  //   super.initState();
  // }
  @override

  final appBar = AppBar(

    title: const Text("Dashboard",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),),
  );
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final scrnHeight =queryData.size.height;
    final barHeight =appBar.preferredSize.height;
    final stbarHeight=queryData.padding.top;
    final conHeight=(scrnHeight-barHeight-stbarHeight);
    return Scaffold (
      resizeToAvoidBottomInset: true,
      drawer: NavPanel(),
      appBar: appBar,
      body: SafeArea(
        child: Container(
          color: Color(0xb337c8f8),
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          width: double.infinity,
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget>[
              Card(
                color: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: conHeight*0.2,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Welcome,",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text("Vehicle Model : ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      ),
                      const Text("Vehicle No : ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      ),
                      Container(
                        padding:const EdgeInsets.only(left: 5),
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget> [

                            Column(
                              children: const [
                                Text("Ready to drive",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          Column(
                              children: [
                                statusSwitch(),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],

                  ),
                 ),
              ),
              Card(
                color: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: double.infinity,
                  height: conHeight*0.47,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text("Map",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(": ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      )
                    ],

                  ),
                 ),
              ),
              Card(// for ride request
                color: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: double.infinity,
                  height: conHeight*0.25,
                  padding: const EdgeInsets.all(10),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget> [
                      const Text("From : ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text("To   : ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      ),
                      const Text("Fare : ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      ),

                      Container(
                        padding:const EdgeInsets.only(left: 10,right: 10,top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                            MaterialButton(
                              minWidth: queryData.size.width*0.4,
                              height: 40,
                              onPressed: () {
                                print("buuto");
                                Navigator.push(context,MaterialPageRoute(builder: (context) => const DriverRegCon()));
                              },
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Accept",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),

                              ),
                            ),

                            SizedBox(width: 10,),
                            MaterialButton(
                              color: Colors.blue,
                              minWidth: queryData.size.width*0.4,
                              height: 40,
                              onPressed: () {
                                appFunctions().driverStatus("Online");
                                print("buuto");
                                print(value);
                                Navigator.push(context,MaterialPageRoute(builder: (context) => const HistoryPage()));
                              },
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Reject",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),

                              ),
                            ),

                          ],
                        ),
                      )

                    ],

                  ),
                 ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget statusSwitch()=>Transform.scale(
    scale: 1.5,
    child:Switch.adaptive(
          value: value,
          activeColor: Colors.blueAccent,
          activeTrackColor: Colors.greenAccent,
          inactiveThumbColor: Colors.red,
          inactiveTrackColor: Colors.black,
          onChanged:(value) =>setState(()=>this.value=value),
      ),
  );
}
