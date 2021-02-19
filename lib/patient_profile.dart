import 'dart:io';


import 'package:doctors_schedule/recorder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PatientProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
// throw UnimplementedError();
    return PatientState();
  }
}

class PatientState extends State<PatientProfile> {
  File _image;
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
// TODO: implement build
//throw UnimplementedError();
    return Scaffold(
        appBar: AppBar(
          title: Text('Kodssdfssd,Ksdhhs'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(34, 82, 160, 1),
        ),
        body: Container(
          color: Colors.grey[300],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: height * 0.15,
                  color: Colors.green,
                  child: ListTile(
                    tileColor: Colors.grey[300],
                    leading: CircleAvatar(
                      radius: 40,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://icon-library.com/images/person-image-icon/person-image-icon-6.jpg"),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '02-12-2021',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'PC-MD',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.grey),
                        ),
                        Text(
                          'Kodssdfssd,Ksdhhs',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '(Male 21)',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.grey),
                        ),
                        Text(
                          'Pending',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "start file",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        print(isSwitched);
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.blue,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>Recorder(),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 28),
                      child: Icon(
                        Icons.mic,
                        color: Colors.white54,
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(34, 82, 160, 1),
                          borderRadius: BorderRadius.circular(40)),
                      width: 70,
                      height: 70,
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      final action = CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
// Icon(Icons.camera, color: Colors.blue),
                                Text("Camera"),
                              ],
                            ),
                            onPressed: () {
                              openCamera();
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
// Icon(Icons.photo_library_outlined,
// color: Colors.blue),
                                Text("Photo Library"),
                              ],
                            ),
                            onPressed: () {
                              openGallery();
                            },
                          )
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      );

                      showCupertinoModalPopup(
                          context: context, builder: (context) => action);},

                    child: Container(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white54,
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(34, 82, 160, 1),
                          borderRadius: BorderRadius.circular(40)),
                      width: 70,
                      height: 70,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // if you need this
                  side: BorderSide(
                    color: Colors.black45,
                    width: 1,
                  ),
                ),
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                  width: 300,
                  height: 110,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Date of birth",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
                              Text("2-17-1992",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
                            ]),
                        SizedBox(height: 20,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("case number",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
                              Text("y-c12345",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),)
                            ]),
                        SizedBox(height: 20,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Pc-Md",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
                              Text("checkout",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: 320,
                margin: EdgeInsets.only(bottom: 15),
                color: Color.fromRGBO(237, 243, 245, 1),
                child: ListTile(
                  leading: Icon(Icons.receipt,color: Colors.blueAccent,),
                  title: Text("Medical  Bill",style: TextStyle(color: Colors.blueAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
              // SizedBox(height: 10,),
              Container(
                width: 320,
                margin: EdgeInsets.only(bottom: 15),
                color: Color.fromRGBO(237, 243, 245, 1),
                child: ListTile(
                  leading: Icon(Icons.notes,color: Colors.blueAccent,),
                  title: Text("prescriptions",style: TextStyle(color: Colors.blueAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
              Container(
                width: 320,
                margin: EdgeInsets.only(bottom: 15),
                color: Color.fromRGBO(237, 243, 245, 1),
                child: ListTile(
                  leading: Icon(Icons.file_copy,color: Colors.blueAccent,),
                  title: Text("Report",style: TextStyle(color: Colors.blueAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),



            ],
          ),
        ));
  }


  Future openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = picture ;
    });
  }

}
