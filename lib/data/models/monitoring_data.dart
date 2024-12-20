class MonitoringData {
  final DateTime timestamp;
  final double value;
  MonitoringData({required this.value, required this.timestamp});
  factory MonitoringData.fromjson(Map<String, dynamic> json){
    return MonitoringData(value: json['value'], timestamp:  DateTime.parse(json['timestamp']));
  }
 
}
