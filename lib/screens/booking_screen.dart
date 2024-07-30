import 'package:flutter/material.dart';
import '../providers/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingScreen extends StatelessWidget {
  final TextEditingController startLocationController = TextEditingController();
  final TextEditingController endLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Ride'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: startLocationController,
              decoration: InputDecoration(
                labelText: 'Start Location',
              ),
            ),
            TextField(
              controller: endLocationController,
              decoration: InputDecoration(
                labelText: 'End Location',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final provider = Provider.of<LocationProvider>(context, listen: false);
                await provider.getPriceEstimate(
                  startLocationController.text,
                  endLocationController.text,
                );
              },
              child: Text('Get Price Estimate'),
            ),
            Consumer<LocationProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return CircularProgressIndicator();
                }
                if (provider.priceEstimate != null) {
                  return Column(
                    children: [
                      Text('Estimated Price: ${provider.priceEstimate}'),
                      SizedBox(height: 20),
                      DropdownButton<String>(
                        value: provider.selectedApp,
                        onChanged: (String? newValue) {
                          provider.setSelectedApp(newValue!);
                        },
                        items: <String>['Uber', 'Ola', 'Rapido']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _openRideSharingApp(
                            provider.selectedApp,
                            startLocationController.text,
                            endLocationController.text,
                          );
                        },
                        child: Text('Book with ${provider.selectedApp}'),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openRideSharingApp(String app, String start, String end) async {
    String? url;
    if (app == 'Uber') {
      url = 'uber://?action=setPickup&pickup[formatted_address]=$start&dropoff[formatted_address]=$end';
    } else if (app == 'Ola') {
      url = 'ola://app/ola?pickup=$start&drop=$end';
    } else if (app == 'Rapido') {
      url = 'rapido://app/book?pickup=$start&drop=$end';
    }
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
