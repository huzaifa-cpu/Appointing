class Admin {
  Admin({
    this.id,
    this.email,
    this.password,
  });

  int id;
  String email;
  String password;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        id: json["id"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
      };
}
