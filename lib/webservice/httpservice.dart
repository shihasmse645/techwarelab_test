import 'package:http/http.dart' as http;

import '../model/employee_model.dart';



class HttpService {
  Future<List<Employees>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse("http://www.mocky.io/v2/5d565297300000680030a986");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return employeesFromJson(json);
    }
    return null;
  }
}