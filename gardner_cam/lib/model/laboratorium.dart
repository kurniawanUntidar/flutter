// class Laboratorium {
//   final String name;
//   final String address;
//   final String web;

//   const Laboratorium({
//     required this.name,
//     required this.address,
//     required this.web,
//     // this.name,
//     // this.address,
//     // this.web,
//   });
// }

class Laboratorium{
  String? name;
  String? address;
  String? web;
Laboratorium({
  this.name,
  this.address,
  this.web
});
Laboratorium.fromJson(Map<String,dynamic>json){
  name = json['Laboratorium']['name'];
  address = json['Laboratorium']['address'];
  web = json['Laboratorium']['web'];
}
}