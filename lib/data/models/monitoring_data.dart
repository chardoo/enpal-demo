class MonitoringData {
  final DateTime timestamp;
  final double value;
  MonitoringData({required this.value, required this.timestamp});
  factory MonitoringData.fromJson(Map<String, dynamic> json){
    return MonitoringData(value: double.parse(json['value'].toString()), timestamp:  DateTime.parse(json['timestamp']));
  }
 
}


