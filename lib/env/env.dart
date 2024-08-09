import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'FIREBASE_KEY', obfuscate: true)
  static final frbApiKey = _Env.frbApiKey;
  @EnviedField(varName: 'PROJECT_ID', obfuscate: true)
  static final pIdKey = _Env.pIdKey;
  @EnviedField(varName: 'AUTH_DOMAIN', obfuscate: true)
  static final authDomain = _Env.authDomain;
  @EnviedField(varName: 'DATA_BASE_URL', obfuscate: true)
  static final databaseURL = _Env.databaseURL;
  @EnviedField(varName: 'PROJECT_ID', obfuscate: true)
  static final projectId = _Env.projectId;
  @EnviedField(varName: 'STORAGE_BUCKET', obfuscate: true)
  static final storageBucket = _Env.storageBucket;
  @EnviedField(varName: 'MESSAGING_SENDER_ID', obfuscate: true)
  static final messagingSenderId = _Env.messagingSenderId;
  @EnviedField(varName: 'APP_ID', obfuscate: true)
  static final appId = _Env.appId;
  @EnviedField(varName: 'MEASUREMENT_ID', obfuscate: true)
  static final measurementId = _Env.measurementId;
}
