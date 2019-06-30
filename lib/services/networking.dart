import 'package:http/http.dart' as http; // this improves code readability!
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.url});

  final String url;

  Future getData() async {
    http.Response response = await http.get(url);

    // if status code is alright, only then store the results in a string variable
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
