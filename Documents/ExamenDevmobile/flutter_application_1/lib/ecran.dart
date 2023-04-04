/*import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressScreen extends StatelessWidget {
  final String message;
  final double percent;

  ProgressScreen({required this.message, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            message,
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 20.0),
          Center(
            child: CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 10.0,
              percent: percent,
              center: Text(
                '${(percent * 100).round()}%',
                style: TextStyle(fontSize: 20.0),
              ),
              progressColor: Colors.green,
              backgroundColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
*/
