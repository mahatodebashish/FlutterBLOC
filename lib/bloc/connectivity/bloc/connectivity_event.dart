abstract class ConnectivityEvent {}

class ConnectivityCheck extends ConnectivityEvent {}

class ConnectivityUpdate extends ConnectivityEvent {
  final bool isConnected;

  ConnectivityUpdate(this.isConnected);
}

class ConnectivityTypeUpdate extends ConnectivityEvent {
  final String connectionType; // e.g., "WiFi", "Mobile", "None"

  ConnectivityTypeUpdate(this.connectionType);
}
