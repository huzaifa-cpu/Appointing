class PatientExtra {
  PatientExtra(
      {this.patientId,
      this.name,
      this.age,
      this.gender,
      this.image,
      this.phoneNumber});

  String patientId;
  String image;
  String name;
  String age;
  String gender;
  String phoneNumber;

  factory PatientExtra.fromJson(Map<String, dynamic> json) => PatientExtra(
        patientId: json["patientId"],
        name: json["name"],
        age: json["age"],
        image: json["image"],
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "patientId": patientId,
        "name": name,
        "age": age,
        "gender": gender,
        "image": image,
        "phoneNumber": phoneNumber,
      };
}
