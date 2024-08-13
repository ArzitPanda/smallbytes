import 'package:appwrite/appwrite.dart';

class AppwriteClient {
  static final Client _client = Client();

  AppwriteClient._internal() {
    _client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('66b715c4000b41dfc306')
        .setSelfSigned(status: true);
  }

  static final AppwriteClient _instance = AppwriteClient._internal();

  factory AppwriteClient() {
    return _instance;
  }

  Client get client => _client;
}
