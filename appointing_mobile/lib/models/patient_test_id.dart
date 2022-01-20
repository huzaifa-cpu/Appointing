class PatientTestId {
    PatientTestId({
        this.testId,
        this.patientId,
    });

    int testId;
    String patientId;

    factory PatientTestId.fromJson(Map<String, dynamic> json) => PatientTestId(
        testId: json["testId"],
        patientId: json["patientId"],
    );

    Map<String, dynamic> toJson() => {
        "testId": testId,
        "patientId": patientId,
    };
}