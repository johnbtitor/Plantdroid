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
      debugShowCheckedModeBanner: false, // Add this line to remove the debug banner
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebSocketChannel? channel;
  late WebSocketChannel tempChannel;

  Map<String, dynamic> data = {'temperature': '', 'humidity': '', 'light': ''};
  List<FlSpot> temperatureHistory = [];
  List<FlSpot> humidityHistory = [];
  List<FlSpot> lightHistory = [];
  int pointCount = 0;

  @override
  void initState() {
    super.initState();
    tempChannel = WebSocketChannel.connect(Uri.parse('ws://192.168.43.81/ws'));

    tempChannel.stream.listen((message) {
      final parsedData = jsonDecode(message);
      setState(() {
        data = parsedData;
        final time = DateTime.now().millisecondsSinceEpoch.toDouble();
        temperatureHistory.add(FlSpot(time, parsedData['temperature']));
        humidityHistory.add(FlSpot(time, parsedData['humidity']));
        lightHistory.add(FlSpot(time, parsedData['light']));
        pointCount++;

        if (parsedData.containsKey('ip')) {
          _updateWebSocketConnection(parsedData['ip']);
        }
      });
    });
  }

  void _updateWebSocketConnection(String ip) {
    if (channel != null) {
      channel!.sink.close();
    }

    channel = WebSocketChannel.connect(Uri.parse('ws://$ip/ws'));

    channel!.stream.listen((message) {
      final parsedData = jsonDecode(message);
      setState(() {
        data = parsedData;
        final time = DateTime.now().millisecondsSinceEpoch.toDouble();
        temperatureHistory.add(FlSpot(time, parsedData['temperature']));
        humidityHistory.add(FlSpot(time, parsedData['humidity']));
        lightHistory.add(FlSpot(time, parsedData['light']));
        pointCount++;
      });
    }, onError: (error) {
      print('WebSocket error: $error');
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
                  isCurved: false, // Linearly connect the dots
                  colors: [color],
                  dotData: FlDotData(show: true), // Show dots
                  belowBarData: BarAreaData(show: false),
                ),
              ],
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  interval: calculateInterval(), // Calculate interval dynamically
                  getTitles: (value) {
                    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}'; // Show hour and minute
                  },
                ),
                leftTitles: SideTitles(showTitles: true),
              ),
              minY: 0, // Ensure Y-axis starts from 0
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: true),
            ),
          ),
        ),
      ],
    );
  }

  double calculateInterval() {
    // Adjust the interval based on the number of data points to prevent overlap
    if (pointCount < 10) {
      return 60000; // 1 minute in milliseconds
    } else if (pointCount < 50) {
      return 300000; // 5 minutes in milliseconds
    } else if (pointCount < 100) {
      return 600000; // 10 minutes in milliseconds
    } else {
      return 1800000; // 30 minutes in milliseconds
    }
  }

  @override
  void dispose() {
    if (channel != null) {
      channel!.sink.close();
    }
    tempChannel.sink.close();
    super.dispose();
  }
}
