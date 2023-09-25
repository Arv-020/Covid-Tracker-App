import 'dart:convert';

import 'package:covidtracker/Model/worldstate.dart';
import 'package:covidtracker/Services/Utility/appurl.dart';
import 'package:http/http.dart' as http;

class WorldStates {
  Future<WorldModel> fetchdata() async {
    final response = await http.get(Uri.parse(AppUrl.worldstats));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> fetchcountriesdata() async {
    final response = await http.get(Uri.parse(AppUrl.countries));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('error');
    }
  }
}
