import 'package:flutter_contacts/flutter_contacts.dart';

class FlutterContactsHelper {
  Future<bool> requestPermission() => FlutterContacts.requestPermission();

  Future<List<Contact>> getContacts(
          {bool withProperties = false, bool withPhoto = false}) =>
      FlutterContacts.getContacts(
          withProperties: withProperties, withPhoto: withPhoto);

  void addListener(dynamic Function() callback) =>
      FlutterContacts.addListener(callback);

  void removeListener(void Function() callback) =>
      FlutterContacts.removeListener(callback);
}
