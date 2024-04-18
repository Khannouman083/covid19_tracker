import 'dart:convert';

import 'package:covid19_tracker/Models/worldStatesModel.dart';
import 'package:covid19_tracker/Services/utilities/appUrl.dart';
import 'package:http/http.dart' as http;

class statesService {
  Future <WorldStatesModel> fetchWorldStates () async {
    final response = await http.get(Uri.parse(appUrl.worldStatesApi));

    if (response.statusCode==200) {
      var data= jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
  }
    else {
      throw Exception("Error");
    }
}

  Future <List<dynamic>> fetchCountries () async {
    final response = await http.get(Uri.parse(appUrl.countiesList));
    var data;
    if (response.statusCode==200) {
      data= jsonDecode(response.body);
      return data;
    }
    else {
      throw Exception("Error");
    }
  }
}