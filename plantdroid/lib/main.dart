import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Surveillance System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse('ws://10.42.0.127/ws'));

  Map<String, dynamic> data = {'temperature': '', 'humidity': '', 'light': ''};
  List<FlSpot> temperatureHistory = [];
  List<FlSpot> humidityHistory = [];
  List<FlSpot> lightHistory = [];

  @override
  void initState() {
    super.initState();
    channel.stream.listen((message) {
      final parsedData = jsonDecode(message);
      setState(() {
        data = parsedData;
        final time = DateTime.now().millisecondsSinceEpoch.toDouble();
        temperatureHistory.add(FlSpot(time, parsedData['temperature']));
        humidityHistory.add(FlSpot(time, parsedData['humidity']));
        lightHistory.add(FlSpot(time, parsedData['light']));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Surveillance System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Temperature: ${data['temperature']} °C'),
            Text('Humidity: ${data['humidity']} %'),
            Text('Light Intensity: ${data['light']} lux'),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildChart('Temperature Over Time', temperatureHistory, Colors.red),
                  _buildChart('Humidity Over Time', humidityHistory, Colors.blue),
                  _buildChart('Light Intensity Over Time', lightHistory, Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(String title, List<FlSpot> history, Color color) {
    return Column(
      children: [
        Text(title),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: history,
                  isCurved: true,
                  colors: [color],
                  dotData: FlDotData(show: false),
                ),
              ],
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) {
                    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                    return '${date.hour}:${date.minute}:${date.second}';
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
