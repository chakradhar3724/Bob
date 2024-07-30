import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationProvider with ChangeNotifier {
  String? priceEstimate;
  String selectedApp = 'Uber';
  bool isLoading = false;

  Future<void> getPriceEstimate(String start, String end) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/price-estimate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'startLocation': start, 'endLocation': end}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        priceEstimate = data['price'];
      } else {
        throw Exception('Failed to load price estimate');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedApp(String app) {
    selectedApp = app;
    notifyListeners();
  }
}
