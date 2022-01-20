class AppointmentId {
    AppointmentId({
        this.doctorId,
        this.patientId,
    });

    int doctorId;
    String patientId;

    factory AppointmentId.fromJson(Map<String, dynamic> json) => AppointmentId(
        doctorId: json["doctorId"],
        patientId: json["patientId"],
    );

    Map<String, dynamic> toJson() => {
        "doctorId": doctorId,
        "patientId": patientId,
    };
}