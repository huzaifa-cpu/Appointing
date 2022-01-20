class Test {
  Test({
    this.testId,
    this.name,
    this.fee,
    this.description,
  });

  int testId;
  String name;
  String fee;
  String description;

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        testId: json["testId"],
        name: json["name"],
        fee: json["fee"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "testId": testId,
        "name": name,
        "fee": fee,
        "description": description,
      };
}
