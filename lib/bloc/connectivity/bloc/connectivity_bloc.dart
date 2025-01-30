import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;

  ConnectivityBloc(this._connectivity) : super(ConnectivityInitial()) {
    on<ConnectivityCheck>(_onConnectivityCheck);
    on<ConnectivityUpdate>(_onConnectivityUpdate);
    on<ConnectivityTypeUpdate>(_onConnectivityTypeUpdate);

    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi) {
        add(ConnectivityTypeUpdate("WiFi"));
      } else if (result == ConnectivityResult.mobile) {
        add(ConnectivityTypeUpdate("Mobile"));
      } else {
        add(ConnectivityTypeUpdate("None"));
      }
    });
  }

  Future<void> _onConnectivityCheck(
      ConnectivityCheck event, Emitter<ConnectivityState> emit) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    final connectionType = connectivityResult == ConnectivityResult.wifi
        ? "WiFi"
        : connectivityResult == ConnectivityResult.mobile
            ? "Mobile"
            : "None";

    if (connectivityResult != ConnectivityResult.none) {
      emit(ConnectivityConnected(connectionType));
    } else {
      emit(ConnectivityDisconnected());
    }
  }

  Future<void> _onConnectivityUpdate(
      ConnectivityUpdate event, Emitter<ConnectivityState> emit) async {
    final connectionType =
        event.isConnected ? "WiFi" : "None"; // Default to WiFi for manual update

    if (event.isConnected) {
      emit(ConnectivityConnected(connectionType));
    } else {
      emit(ConnectivityDisconnected());
    }
  }

  Future<void> _onConnectivityTypeUpdate(
      ConnectivityTypeUpdate event, Emitter<ConnectivityState> emit) async {
    if (event.connectionType == "None") {
      emit(ConnectivityDisconnected());
    } else {
      emit(ConnectivityConnected(event.connectionType));
    }
  }
}
