import 'dart:io';

Future<bool> checkConnection() async {
  //TODO extract on a common file
  bool _isConnected = false;
// use try-catch to do this operation, so that to get the control over this
// operation better
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // do the operation for connected, or change the bool to True for connected
      _isConnected = true;
    }
  } on SocketException catch (_) {
    _isConnected = false;
  }
  return _isConnected;
}
