class AuthModel {
  int? id;
  String? username;
  String? email;
  String? token; // present in login response from fakestoreapi

  AuthModel({
    this.id,
    this.username,
    this.email,
    this.token,
  });

  AuthModel fromJson(Map<String, dynamic> json) => AuthModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        token: json["token"], // set when logging in
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'token': token,
      };
}
