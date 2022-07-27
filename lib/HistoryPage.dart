import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'RegCon.dart';
import 'appFunctions.dart';
import 'databaseoperations.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final wid=MediaQuery.of(context).size.width;
    final scrnHeight =MediaQuery.of(context).size.height;
    final stbarHeight=MediaQuery.of(context).padding.top;
    final conHeight=(scrnHeight-stbarHeight);


    Stream<List<Driver>> readDrivers()=> FirebaseFirestore
        .instance
        .collection('driverdetails')
        .snapshots().map((snapshot) => snapshot.docs.map((doc)=>Driver.fromJson(doc.data())).toList());

    Widget buildDriver(Driver driver)=>ListTile(
      leading: const CircleAvatar(child: Icon(
        Icons.ice_skating_outlined,
      ),),

      title: Text(driver.name),
      subtitle: Text(driver.phone!.toString()),
    );

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
          "Recent Rides",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),



      body: SafeArea(
        child: StreamBuilder<List<Driver>>(

          stream: readDrivers(),
          builder: (context,snapshot){

            if(snapshot.hasError){
              return const Text("something went wrong");
            }else if(snapshot.hasData){
              final driveHistory = snapshot.data!;

              return ListView(
                children: driveHistory.map(buildDriver).toList(),

              );
            } else {
              return const SizedBox(height: 5,);
            }
          }

        ),

        /*Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          // constraints: const BoxConstraints.expand(),
          // decoration: const BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage("assets/img1.jpg"), fit: BoxFit.fill)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 20,
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: (queryData.size.width-40),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade100,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Image.asset("img1.jpg",width: 30,height: 30),

                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Container(
                                        width: (queryData.size.width-90)*0.5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "tehuihst",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "test",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: (queryData.size.width-40)*0.3,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children:const [
                                            Text("testat",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(left: 5,top: 8),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),

                          ],
                        ),

                    ),

              ),
              ),
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
        ),*/
      ),
    );

  }
  Widget getHistory(){
    return IndexedStack(

    );
  }
}
