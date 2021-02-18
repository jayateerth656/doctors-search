class DoctorJson {
  int id;
  String date;
  String name;
  String location;
  String doctorName;
  String status;
  String appointmentTime;

  DoctorJson(
      {this.id,
        this.date,
        this.name,
        this.location,
        this.doctorName,
        this.status,
        this.appointmentTime});

  DoctorJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    name = json['name'];
    location = json['location'];
    doctorName = json['doctorName'];
    status = json['status'];
    appointmentTime = json['appointmentTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['name'] = this.name;
    data['location'] = this.location;
    data['doctorName'] = this.doctorName;
    data['status'] = this.status;
    data['appointmentTime'] = this.appointmentTime;
    return data;
  }
}