import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tdd_clean/core/platform/network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl(this.internetConnectionChecker);

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
