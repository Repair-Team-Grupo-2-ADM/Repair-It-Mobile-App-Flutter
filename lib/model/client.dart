import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

class Client {
  int id;
  String email;
  String password;
  String address;
  String planType;
  String firstName;
  String lastName;
  String cellPhoneNumber;

  Client(
      {required this.id,
      required this.email,
      required this.password,
      required this.address,
      required this.firstName,
      required this.lastName,
      required this.cellPhoneNumber,
      required this.planType});

  factory Client.fromJson(Map<String, dynamic> parsedJson) {
    return Client(
        id: parsedJson['id'],
        email: parsedJson['email'],
        password: parsedJson['password'],
        address: parsedJson['address'],
        firstName: parsedJson['firstName'],
        lastName: parsedJson['lastName'],
        cellPhoneNumber: parsedJson['cellPhoneNumber'],
        planType: parsedJson['planType']);
  }
}
