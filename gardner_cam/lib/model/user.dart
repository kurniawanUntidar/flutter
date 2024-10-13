class User {
  final String? name;
  final String? address;
  final String? web;

  User(this.name, this.address, this.web);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        address = json['address'],
        web = json['web'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'web': web,
      };
}
