class User {
  String? id;
  String? name;
  int? edad;
  String? email;
  String? password;

  User(
    this.id,
    this.name,
    this.edad,
    this.email,
    this.password,
  );

  User.withoutID(
    this.name,
    this.edad,
    this.email,
    this.password,
  );

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    edad = json['edad'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['nombre'] = name;
    data['edad'] = edad;
    data['correo'] = email;
    data['password'] = password;

    return data;
  }
}
