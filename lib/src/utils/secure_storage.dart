import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _emailKey = 'EMAIL';
const _photoKey = 'PHOTO';
const _usernameKey = 'USERNAME';


class SecureStorage {
  SecureStorage._secureStorage();

  static final SecureStorage _instance = SecureStorage._secureStorage();

  static SecureStorage get instance => _instance;

  final _secureStorage = const FlutterSecureStorage();

  Future<void> persistEmail(String email) async =>
      await _secureStorage.write(key: _emailKey, value: email);

  Future<void> persistPhoto(String photo) async =>
      await _secureStorage.write(key: _photoKey, value: photo);

  Future<void> persistUsername(String username) async =>
      await _secureStorage.write(key: _usernameKey, value: username);

  Future<String?> getEmail() async => await _secureStorage.read(key: _emailKey);

  Future<String?> getPhoto() async => await _secureStorage.read(key: _photoKey);

  Future<String?> getUsername() async =>
      await _secureStorage.read(key: _usernameKey);

  Future<void> deleteAll() async => await _secureStorage.deleteAll();
}
