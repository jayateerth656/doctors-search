import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'package:flutter/material.dart';import 'dart:convert';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class FlightDetailsScreen extends StatefulWidget {
  @override
  _FlightDetailsScreenState createState() => _FlightDetailsScreenState ();
}

class _FlightDetailsScreenState extends State<FlightDetailsScreen> {
  final String url = "assets/doctorAppointment.json";
  List<dynamic> allData = [];
  List<dynamic> appointmentData = [];
  Map<String, dynamic> appointment;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    this.getjsondata();
  }

// ignore: missing_return
  Future<String> getjsondata() async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/doctorAppointment.json");
    final jsonResult = json.decode(jsonData);

// print(jsonResult)
    allData = jsonResult;
    appointmentData = allData;
    setState(() {});
  }

  getSelectedDateAppointments() {
// for (var i = 0; i < appointmentData.length; i++) {
// Map<String, dynamic> appItem = appointmentData[i];
// if (appItem['appointmentDate'] == _selectedValue.toString()) {
// appointment = appItem;
// print(appItem);
// }
// }

    appointmentData = allData.where((element) {

      Map<String, dynamic> appItem = element;
      return appItem['appointmentDate'] == _selectedValue.toString();
    }).toList();
    print(appointmentData);
    setState(() {});
  }

  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final _PatientSearchCard = Card(
      elevation: 4.0,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        margin: EdgeInsets.only(top: 0.0),
        height: 60.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              trailing: Icon(Icons.search),
              title: new TextField(

                decoration: InputDecoration(hintText: "Search Patients"),
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      drawer: Container(),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Color.fromRGBO(34, 82, 160, 1),
        title: ListTile(
          leading: CircleAvatar(
            radius: 18,
            child: ClipOval(
              child: Image.network(
                  "https://image.freepik.com/free-vector/doctor-icon-avatar-white_136162-58.jpg"),
            ),
          ),
          title: Text(
            "Welcome Dr.sciliaris",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          trailing: Icon(
            Icons.notification_important,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
//color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.10,
              color: Color.fromRGBO(34, 82, 160, 1),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.10,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  children: <Widget>[
                    _PatientSearchCard,
                    Container(
                      child: DatePicker(
                        DateTime.now(),
                        width: 50,
                        height: 80,
                        controller: _controller,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Color.fromRGBO(34, 82, 160, 1),
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          setState(() {
                            _selectedValue = date;
                            print(_selectedValue);
                            getSelectedDateAppointments();
                          });

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  SafeArea(
                    bottom: false,
                    child: Stack(
                      children: <Widget>[
                        DraggableScrollableSheet(
                          maxChildSize: .7,
                          initialChildSize: .7,
                          // minChildSize: .6,
                          builder: (context, scrollController) {
                            return Container(
                              height: 100,
                              padding: EdgeInsets.only(
                                  left: 19,
                                  right: 19,
                                  top:
                                  16), //symmetric(horizontal: 19, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                color: Colors.white,
                              ),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                controller: scrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "HEMA 54-DEAN (4)",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        )
                                      ],
                                    ),
                                    appointmentData != null &&
                                        appointmentData.isNotEmpty
                                        ? ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      separatorBuilder:
                                          (context, index) => Divider(
                                        color: Colors.black,
                                      ),
                                      shrinkWrap: true,
                                      itemCount: appointmentData.length,
                                      itemBuilder: (context, index) {
                                        Map<String, dynamic> item =
                                        appointmentData[index];
                                        return ListTile(
                                          contentPadding:
                                          EdgeInsets.all(0),
                                          leading: Icon(
                                            Icons.bookmark,
                                            color: Colors.green,
                                          ),
                                          title: Text(item["location"]),
                                          subtitle: Text(
                                              item["providerName"] +
                                                  "\n" +
                                                  item["status"]),
                                          trailing: Column(
                                            children: [
                                              Text(item[
                                              "appointmentTime"]),
                                              Spacer(),
                                              RichText(
                                                text: TextSpan(
                                                  text: '• ',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'Dictation' +
                                                          "" +
                                                          "" +
                                                          item[
                                                          "dictationStatus"],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                        : Container(
                                        child: Text(
                                          "No Appointments",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey),
                                        )),
                                    Divider(
                                      thickness: .5,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 20.0,
      width: 20.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}































































// class DoctorAppointment extends StatefulWidget {
//
//   @override
//   _DoctorAppointmentState createState() => _DoctorAppointmentState();
// }
//
// class _DoctorAppointmentState extends State<DoctorAppointment> {
//   DatePickerController _controller = DatePickerController();
//
//   DateTime _selectedValue = DateTime.now();
//   @override
//
//   final String url = "assets/doctorAppointment.json";
//   List<dynamic> appointmentData;
//   var isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     this.getjsondata();
//   }
//
//   // ignore: missing_return
//   Future<String> getjsondata() async {
//     String jsonData = await DefaultAssetBundle.of(context)
//         .loadString("assets/doctorAppointment.json");
//     final List<dynamic> jsonResult = json.decode(jsonData);
//
//     // print(jsonResult);
//     appointmentData = jsonResult;
//   }
//
//   getSelectedDateAppointments() {
//     for (var i = 0; i < appointmentData.length; i++) {
//       Map<String, dynamic> appItem = appointmentData[i];
//       if (appItem['date'] == _selectedValue.toString()) {
//         print(appItem);
//       }
//     }
//   }
//
//
//
//
//
//
//
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           drawer: Container(),
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Color.fromRGBO(34, 82, 160, 1),
//             title: ListTile(
//               leading: ClipRRect(
//                 borderRadius: BorderRadius.circular(50),
//                 child: Container(
//                     height: 35,
//                     width: 35,
//                     child: Image.network(
//                         "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg")),
//               ),
//               title: Text(
//                 "Welcome Dr. Scilaris",
//                 style: TextStyle(color: Colors.white),
//               ),
//               trailing: Icon(Icons.menu_open,color: Colors.white,),
//             ),
//           ),
//           body: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
// //color: Colors.black,
//             child: Stack(
//               alignment: Alignment.topCenter,
//               children: <Widget>[
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height * 0.06,
//                   color: Color.fromRGBO(34, 82, 160, 1),
//                 ),
//                 Positioned(
//                   top: MediaQuery.of(context).size.width * 0.03,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.90,
//                     child: Column(
//                       children: <Widget>[
// // FlightCard(
// // flight: flight,
// // isClickable: false,
// // ),
//
//                         Card(
//                           elevation: 4.0,
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0)),
//                           child: Container(
//                             margin: EdgeInsets.only(top: 0.0),
//                             height: 56.0,
//                             width: 320.0,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: <Widget>[
//                                 ListTile(
//                                   title: TextFormField(
//                                     decoration: new InputDecoration(
//                                         border: InputBorder.none,
//                                         contentPadding:
//                                         const EdgeInsets.only(bottom: 0),
//                                         hintText: "Search Patients"),
//                                   ),
//                                   trailing: Container(
//                                     child: Icon(
//                                       Icons.search,
//                                     ),
//                                     padding: const EdgeInsets.only(bottom: 0),
//                                   ),
//
//
//
//
//
//
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15,),
//                         Container(
//                           child: DatePicker(
//                             DateTime.now(),
//                             width: 50,
//                             height: 80,
//                             controller: _controller,
//                             initialSelectedDate: DateTime.now(),
//                             selectionColor: Color.fromRGBO(34, 82, 160, 1),
//                             selectedTextColor: Colors.white,
//                             // inactiveDates: [
//                             //   DateTime.now().add(Duration(days: 3)),
//                             //   DateTime.now().add(Duration(days: 4)),
//                             //   DateTime.now().add(Duration(days: 5)),
//                             // ],
//                             onDateChange: (date) {
//                               // New date selected
//                               setState(() {
//                                 _selectedValue = date;
//                                 getSelectedDateAppointments();
//                                 // print(_selectedValue);
//                               }
//
//
//                               );
//                             },
//                           ),
//                         ),
//
//
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 10,),
//                 Container(
//                   child: Stack(
//                     children: <Widget>[
//                       SafeArea(
//                         bottom: false,
//                         child: Stack(
//                           children: <Widget>[
//                             DraggableScrollableSheet(
//                               maxChildSize: .8,
//                               initialChildSize: .6,
//                               minChildSize: .6,
//                               builder: (context, scrollController) {
//                                 return Container(
//                                   height: 90,
//                                   padding: EdgeInsets.only(
//                                       left: 19,
//                                       right: 19,
//                                       top:
//                                       16), //symmetric(horizontal: 19, vertical: 16),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(29),
//                                         topRight: Radius.circular(29),
//                                         bottomLeft: Radius.circular(30),
//                                       bottomRight: Radius.circular(30),
//                                          ),
//
//                                     color: Colors.white,
//                                   ),
//                                   child: SingleChildScrollView(
//                                     physics: BouncingScrollPhysics(),
//                                     controller: scrollController,
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               "HEMA 54-DEAN (4)",
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 18.0),
//                                             )
//                                           ],
//                                         ),
//                                         ListTile(
//                                           contentPadding: EdgeInsets.all(0),
//                                           leading: Icon(
//                                             Icons.bookmark,
//                                             color: Colors.green,
//                                           ),
//                                           title: Text("Deidra Ella"),
//                                           subtitle:
//                                           Text("Dr.Sciliaris Ella \n NYWC IE-"),
//                                           trailing: Column(
//                                             children: [
//                                               Text("11.00 AM"),
//                                               Spacer(),
//                                               RichText(
//                                                 text: TextSpan(
//                                                   text: '• ',
//                                                   style: TextStyle(
//                                                       color: Colors.red,
//                                                       fontSize: 14),
//                                                   children: <TextSpan>[
//                                                     TextSpan(
//                                                       text: 'Dictation Pending',
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Divider(
//                                           thickness: .5,
//                                           color: Colors.grey,
//                                         ),
//                                         ListTile(
//                                           contentPadding: EdgeInsets.all(0),
//                                           leading: Icon(
//                                             Icons.save_alt,
//                                             color: Colors.white,
//                                           ),
//                                           title: Text("Deidra Ella"),
//                                           subtitle:
//                                           Text("Dr.Sciliaris Ella \n NYWC IE-"),
//                                           trailing: Column(
//                                             children: [
//                                               Text("11.00 AM"),
//                                               Spacer(),
//                                               Text("Dictation Pending"),
//                                             ],
//                                           ),
//                                         ),
//                                         Divider(
//                                           thickness: .5,
//                                           color: Colors.grey,
//                                         ),
//                                         ListTile(
//                                           contentPadding: EdgeInsets.all(0),
//                                           leading: Icon(
//                                             Icons.bookmark,
//                                             color: Colors.green,
//                                           ),
//                                           title: Text("Deidra Ella"),
//                                           subtitle:
//                                           Text("Dr.Sciliaris Ella \n NYWC IE-"),
//                                           trailing: Column(
//                                             children: [
//                                               Text("11.00 AM"),
//                                               Spacer(),
//                                               RichText(
//                                                 text: TextSpan(
//                                                   text: '• ',
//                                                   style: TextStyle(
//                                                       color: Colors.red,
//                                                       fontSize: 14),
//                                                   children: <TextSpan>[
//                                                     TextSpan(
//                                                       text: 'Dictation Pending',
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Divider(
//                                           thickness: .5,
//                                           color: Colors.grey,
//                                         ),
//                                         ListTile(
//                                           contentPadding: EdgeInsets.all(0),
//                                           leading: Icon(
//                                             Icons.bookmark,
//                                             color: Colors.green,
//                                           ),
//                                           title: Text("Deidra Ella"),
//                                           subtitle:
//                                           Text("Dr.Sciliaris Ella \n NYWC IE-"),
//                                           trailing: Column(
//                                             children: [
//                                               Text("11.00 AM"),
//                                               Spacer(),
//                                               Text("Dictation Pending"),
//                                             ],
//                                           ),
//                                         ),
//                                         Divider(
//                                           thickness: .1,
//                                           color: Colors.grey,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                           children: [
//                                             Text("HEASC 54-DEAN (17)",
//                                                 textAlign: TextAlign.center,
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18.0))
//                                           ],
//                                         ),
//                                         ListTile(
//                                           contentPadding: EdgeInsets.all(0),
//                                           leading: Icon(
//                                             Icons.bookmark,
//                                             color: Colors.green,
//                                           ),
//                                           title: Text("Deidra Ella"),
//                                           subtitle:
//                                           Text("Dr.Sciliaris Ella \n NYWC IE-"),
//                                           trailing: Column(
//                                             children: [
//                                               Text("11.00 AM"),
//                                               Spacer(),
//                                               RichText(
//                                                 text: TextSpan(
//                                                   text: '• ',
//                                                   style: TextStyle(
//                                                       color: Colors.red,
//                                                       fontSize: 14),
//                                                   children: <TextSpan>[
//                                                     TextSpan(
//                                                       text: 'Dictation Pending',
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
// // Text("Dictation Pending"),
//                                             ],
//                                           ),
//                                         ),
//                                         Divider(
//                                           thickness: .5,
//                                           color: Colors.grey,
//                                         ),
//                                         ListTile(
//                                           contentPadding: EdgeInsets.all(0),
//                                           leading: Icon(
//                                             Icons.save_alt,
//                                             color: Colors.white,
//                                           ),
//                                           title: Text("Deidra Ella"),
//                                           subtitle:
//                                           Text("Dr.Sciliaris Ella \n NYWC IE-"),
//                                           trailing: Column(
//                                             children: [
//                                               Text("11.00 AM"),
//                                               Spacer(),
//                                               Text("Dictation Pending"),
//                                             ],
//                                           ),
//                                         ),
//                                         Divider(
//                                           thickness: .5,
//                                           color: Colors.grey,
//                                         ),
//                                         ListTile(
//                                           contentPadding: EdgeInsets.all(0),
//                                           leading: Icon(
//                                             Icons.bookmark,
//                                             color: Colors.green,
//                                           ),
//                                           title: Text("Deidra Ella"),
//                                           subtitle:
//                                           Text("Dr.Sciliaris Ella \n NYWC IE-"),
//                                           trailing: Column(
//                                             children: [
//                                               Text("11.00 AM"),
//                                               Spacer(),
//                                               Text("Dictation Pending"),
//                                             ],
//                                           ),
//                                         ),
//                                         Divider(
//                                           thickness: .5,
//                                           color: Colors.grey,
//                                         ),
//                                         ListTile(
//                                           contentPadding: EdgeInsets.all(0),
//                                           leading: Icon(
//                                             Icons.bookmark,
//                                             color: Colors.green,
//                                           ),
//                                           title: Text("Deidra Ella"),
//                                           subtitle:
//                                           Text("Dr.Sciliaris Ella \n NYWC IE-"),
//                                           trailing: Column(
//                                             children: [
//                                               Text("11.00 AM"),
//                                               Spacer(),
//                                               Text("Dictation Pending"),
//                                             ],
//                                           ),
//                                         ),
//
//
//
//
//
//
//
//                                         Divider(
//                                           thickness: .5,
//                                           color: Colors.grey,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Color.fromRGBO(34, 82, 160, 1),
//           onPressed: () {},
//           tooltip: 'Add',
//           child: Icon(
//             Icons.add,
//             size: 40,
//           ),
//         ),
//       ),
//     );
//   }
// }
//








