abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {
  final String connectionType; // "WiFi" or "Mobile"

  ConnectivityConnected(this.connectionType);
}

class ConnectivityDisconnected extends ConnectivityState {}
