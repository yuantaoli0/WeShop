import 'package:get_storage/get_storage.dart';

class JConfig {
  GetStorage? box;
  JConfig() {
    box = GetStorage();
  }

  static init() async {
    await GetStorage.init();
  }

  operator [](String key) {
    return box?.read(key);
  }

  operator []=(key, value) {
    box?.write(key, value);
  }

  del() async {
    box?.erase();
  }

  save() async {
    await box?.save();
  }
}
