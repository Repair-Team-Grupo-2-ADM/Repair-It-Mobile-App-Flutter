import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<http.Response> login(username, password) async {
  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  const String userQuery = '${urlBase}users/auth/sign-in';
  http.Response response = await http.post(Uri.parse(userQuery),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({"username": username, "password": password}));

  if (response.statusCode == HttpStatus.ok) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.decode(response.body);
    await prefs.setString('jwt', body['token']);
    await prefs.setString('username', body['username']);
    await prefs.setString('userType', body['roles'][0]);
    print("Login passed.");
    return response;
  } else {
    print("Failed login.");
    print(response.body);
    return response;
  }
}

Future<http.Response> createClient(email, username, firstname, lastname,
    address, password, cellPhoneNumber, planType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('jwt');

  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  const String clientQuery = '${urlBase}clients';
  http.Response response = await http.post(Uri.parse(clientQuery),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
      body: json.encode({
        "username": username,
        "names": firstname,
        "lastNames": lastname,
        "address": address,
        "email": email,
        "password": password,
        "cellPhoneNumber": cellPhoneNumber,
        "planType": "free"
      }));

  if (response.statusCode == HttpStatus.ok) {
    print("Create client passed.");
    return response;
  } else {
    print("Create client failed.");
    return response;
  }
}

Future<http.Response> createTechnician(email, username, firstname, lastname,
    address, password, cellPhoneNumber) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('jwt');
  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  const String clientQuery = '${urlBase}technicians';
  http.Response response = await http.post(Uri.parse(clientQuery),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
      body: json.encode({
        "username": username,
        "names": firstname,
        "lastNames": lastname,
        "address": address,
        "email": email,
        "password": password,
        "cellPhoneNumber": cellPhoneNumber
      }));

  if (response.statusCode == HttpStatus.ok) {
    print("Create technician passed.");
    return response;
  } else {
    print("Create technician failed.");
    print(response.body);
    return response;
  }
}

Future<http.Response> updateClientPlan(newPlan) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? username = prefs.getString("username");
  String? token = prefs.getString('jwt');

  var data = await getClientByUsername(username);
  var client = json.decode(data.body);

  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  String clientQuery = '${urlBase}clients/' + client['id'].toString();
  http.Response response = await http.put(Uri.parse(clientQuery),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
      body: json.encode({
        "username": username,
        "names": client["names"],
        "lastNames": client["lastNames"],
        "address": client["address"],
        "email": client["email"],
        "password": client["password"],
        "cellPhoneNumber": client["cellPhoneNumber"],
        "planType": newPlan
      }));

  if (response.statusCode == HttpStatus.ok) {
    print("Update client plan passed.");
    print(json.decode(response.body));
    return response;
  } else {
    print("Update client plan failed.");
    print(json.decode(response.body));
    return response;
  }
}

Future<http.Response> updateClient(
    email, firstname, lastname, address, password, cellPhoneNumber) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? username = prefs.getString("username");
  String? token = prefs.getString('jwt');

  var data = await getClientByUsername(username);
  var client = json.decode(data.body);

  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  String clientQuery = '${urlBase}clients/' + client['id'].toString();
  http.Response response = await http.put(Uri.parse(clientQuery),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
      body: json.encode({
        "username": username,
        "names": firstname,
        "lastNames": lastname,
        "address": address,
        "email": email,
        "password": password,
        "cellPhoneNumber": cellPhoneNumber,
        "planType": client["planType"]
      }));

  if (response.statusCode == HttpStatus.ok) {
    print("Update client passed.");
    print(json.decode(response.body));
    return response;
  } else {
    print("Update client failed.");
    print(json.decode(response.body));
    return response;
  }
}

Future<http.Response> getAppointmentsByUserId(userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? userType = prefs.getString("userType");
  String? username = prefs.getString("username");
  String? token = prefs.getString('jwt');
  String query;
  http.Response response;
  var data;
  var user;
  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  if (userType == "ROLE_CLIENT") {
    data = await getClientByUsername(username);
    user = json.decode(data.body);
    query =
        '${urlBase}appointments/' + userId.toString() + "/clients/appointments";
    response = await http.get(Uri.parse(query), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": 'Bearer $token',
    });
  } else {
    data = await getTechnicianByUsername(username);
    user = json.decode(data.body);
    query = '${urlBase}appointments/' +
        userId.toString() +
        "/technicians/appointments";
    response = await http.get(Uri.parse(query), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": 'Bearer $token',
    });
  }

  if (response.statusCode == HttpStatus.ok) {
    print("Get user appointments passed.");
    print(json.decode(response.body));
    return response;
  } else {
    print("Get user appointments failed.");
    print(json.decode(response.body));
    return response;
  }
}

Future<http.Response> getClientByUsername(username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('jwt');
  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  String clientQuery = '${urlBase}clients/username/' + username;
  http.Response response = await http.get(Uri.parse(clientQuery), headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Authorization": 'Bearer $token',
  });

  if (response.statusCode == HttpStatus.ok) {
    print("Get client passed.");
    print(json.decode(response.body));
    return response;
  } else {
    print("Get client failed.");
    print(response.body);
    return response;
  }
}

Future<http.Response> getTechnicianByUsername(username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('jwt');
  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  String clientQuery = '${urlBase}technicians/username/' + username;
  http.Response response = await http.get(Uri.parse(clientQuery), headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Authorization": 'Bearer $token',
  });

  if (response.statusCode == HttpStatus.ok) {
    print("Get technician passed.");
    print(json.decode(response.body));
    return response;
  } else {
    print("Get technician failed.");
    print(json.decode(response.body));
    return response;
  }
}

Future<http.Response> signupUser(email, username, password, userType) async {
  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  const String query = '${urlBase}users/auth/sign-up';
  http.Response response = await http.post(Uri.parse(query),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode({
        "username": username,
        "email": email,
        "password": password,
        "roles": [userType]
      }));

  if (response.statusCode == HttpStatus.ok) {
    print("Signup user passed.");
    return response;
  } else {
    print("Signup user failed.");
    print(response.body);
    return response;
  }
}

Future<http.Response> getAllReportsByTechnicianId(technicianId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('jwt');
  print("OROROROROR");
  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  String query = '${urlBase}reports/' + technicianId + '/technicians/reports';
  http.Response response = await http.get(Uri.parse(query), headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Authorization": 'Bearer $token',
  });

  if (response.statusCode == HttpStatus.ok) {
    print("Get All Reports by TechnicianId passed.");
    return response;
  } else {
    print("Get All Reports by TechnicianId failed.");
    print(response.body);
    return response;
  }
}

Future<http.Response> getAllAppliancesByClientId(clientId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('jwt');
  print("OROROROROR");
  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  String query = '${urlBase}applianceModels/' + clientId + '/applianceModels';
  http.Response response = await http.get(Uri.parse(query), headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Authorization": 'Bearer $token',
  });

  if (response.statusCode == HttpStatus.ok) {
    print("Get All Appliances by ClientId passed.");
    return response;
  } else {
    print("Get All Appliances by ClientId failed.");
    print(response.body);
    return response;
  }
}

Future<http.Response> getAllAppointmentsByTechnicianId(technicianId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('jwt');
  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  String query =
      '${urlBase}appointments/' + technicianId + '/technicians/appointments';
  http.Response response = await http.get(Uri.parse(query), headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Authorization": 'Bearer $token',
  });

  if (response.statusCode == HttpStatus.ok) {
    print("Get All Reports by TechnicianId passed.");
    return response;
  } else {
    print("Get All Reports by TechnicianId failed.");
    print(response.body);
    return response;
  }
}

Future<http.Response> createReport(technicianId, appointmentId, observation,
    diagnosis, description, date) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('jwt');
  const String urlBase =
      'https://safetecnology-apiservice.herokuapp.com/api/v1/';
  String query = '${urlBase}reports/' + technicianId + '/' + appointmentId;
  http.Response response = await http.post(Uri.parse(query),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
      body: json.encode({
        "observation": observation,
        "diagnosis": diagnosis,
        "repairDescription": description,
        "date": date,
      }));

  if (response.statusCode == HttpStatus.ok) {
    print("Get All Reports by TechnicianId passed.");
    return response;
  } else {
    print("Get All Reports by TechnicianId failed.");
    print(response.body);
    return response;
  }
}
