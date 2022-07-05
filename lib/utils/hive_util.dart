import 'package:hive/hive.dart';
import 'dart:developer';

mixin HiveUtil {
  Future<void> saveBox<T>(String boxKey, T data,
      {dynamic key, List<int>? encryKey}) async {
    late Box<T> box;
    if (Hive.isBoxOpen(boxKey)) {
      box = Hive.box<T>(boxKey);
    } else {
      box = await Hive.openBox<T>(boxKey,
          encryptionCipher: encryKey != null ? HiveAesCipher(encryKey) : null);
    }
    await box.put(key ?? boxKey, data);
  }

  Future<void> saveLazyBox<T>(String boxKey, T data,
      {dynamic key, List<int>? encryKey}) async {
    late LazyBox<T> box;
    if (Hive.isBoxOpen(boxKey)) {
      box = Hive.lazyBox<T>(boxKey);
    } else {
      box = await Hive.openLazyBox<T>(boxKey,
          encryptionCipher: encryKey != null ? HiveAesCipher(encryKey) : null);
    }
    await box.put(key ?? boxKey, data);
  }

  Future<void> addBox<T>(String boxKey, T data, {List<int>? encryKey}) async {
    late Box<T> box;
    if (Hive.isBoxOpen(boxKey)) {
      box = Hive.box<T>(boxKey);
    } else {
      box = await Hive.openBox<T>(boxKey,
          encryptionCipher: encryKey != null ? HiveAesCipher(encryKey) : null);
    }
    await box.add(data);
  }

  Future<void> addLazyBox<T>(String boxKey, T data,
      {List<int>? encryKey}) async {
    late LazyBox<T> box;
    if (Hive.isBoxOpen(boxKey)) {
      box = Hive.lazyBox<T>(boxKey);
    } else {
      box = await Hive.openLazyBox<T>(boxKey,
          encryptionCipher: encryKey != null ? HiveAesCipher(encryKey) : null);
    }
    await box.add(data);
  }

  Future<T?> getBox<T>(String boxKey,
      {dynamic key, List<int>? encryKey, T? defaultValue}) async {
    late Box<T> box;
    if (Hive.isBoxOpen(boxKey)) {
      box = Hive.box<T>(boxKey);
    } else {
      box = await Hive.openBox<T>(boxKey,
          encryptionCipher: encryKey != null ? HiveAesCipher(encryKey) : null);
    }
    return box.get(key);
  }

  Future<void> getLazyBox<T>(String boxKey,
      {dynamic key, List<int>? encryKey, T? defaultValue}) async {
    late LazyBox<T> box;
    if (Hive.isBoxOpen(boxKey)) {
      box = Hive.lazyBox<T>(boxKey);
    } else {
      box = await Hive.openLazyBox<T>(boxKey,
          encryptionCipher: encryKey != null ? HiveAesCipher(encryKey) : null);
    }
    await box.get(key!);
  }

  Future<Box<T>> getAllBox<T>(String boxKey, {List<int>? encryKey}) async {
    late Box<T> box;
    if (Hive.isBoxOpen(boxKey)) {
      box = Hive.box<T>(boxKey);
    } else {
      box = await Hive.openBox<T>(boxKey,
          encryptionCipher: encryKey != null ? HiveAesCipher(encryKey) : null);
    }
    return Future<Box<T>>.value(box);
  }

  Future<LazyBox<T>> getAllLazyBox<T>(String boxKey,
      {List<int>? encryKey}) async {
    late LazyBox<T> box;
    if (Hive.isBoxOpen(boxKey)) {
      box = Hive.lazyBox<T>(boxKey);
    } else {
      box = await Hive.openLazyBox<T>(boxKey,
          encryptionCipher: encryKey != null ? HiveAesCipher(encryKey) : null);
    }
    return Future<LazyBox<T>>.value(box);
  }

  Future<void> closeLazyBox<T>(String boxKey, {List<int>? encryKey}) async {
    try {
      late LazyBox<T> box;
      if (Hive.isBoxOpen(boxKey)) {
        box = Hive.lazyBox<T>(boxKey);
      } else {
        box = await Hive.openLazyBox<T>(boxKey,
            encryptionCipher:
                encryKey != null ? HiveAesCipher(encryKey) : null);
      }
      await box.close();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> closeBox<T>(String boxKey, {List<int>? encryKey}) async {
    try {
      late Box<T> box;
      if (Hive.isBoxOpen(boxKey)) {
        box = Hive.box<T>(boxKey);
      } else {
        box = await Hive.openBox<T>(boxKey,
            encryptionCipher:
                encryKey != null ? HiveAesCipher(encryKey) : null);
      }
      await box.close();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteBoxKey<T>(boxKey, key, {List<int>? encryKey}) async {
    try {
      late Box<T> box;
      if (Hive.isBoxOpen(boxKey)) {
        box = Hive.box<T>(boxKey);
      } else {
        box = await Hive.openBox<T>(boxKey,
            encryptionCipher:
                encryKey != null ? HiveAesCipher(encryKey) : null);
      }
      await box.delete(key);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteLazyBoxKey<T>(boxKey, key, {List<int>? encryKey}) async {
    try {
      late LazyBox<T> box;
      if (Hive.isBoxOpen(boxKey)) {
        box = Hive.lazyBox<T>(boxKey);
      } else {
        box = await Hive.openLazyBox<T>(boxKey,
            encryptionCipher:
                encryKey != null ? HiveAesCipher(encryKey) : null);
      }
      await box.delete(key);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteBox<T>(String boxKey, {List<int>? encryKey}) async {
    try {
      late Box<T> box;
      if (Hive.isBoxOpen(boxKey)) {
        box = Hive.box<T>(boxKey);
      } else {
        box = await Hive.openBox<T>(boxKey,
            encryptionCipher:
                encryKey != null ? HiveAesCipher(encryKey) : null);
      }
      await box.clear();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteLazyBox<T>(String boxKey, {List<int>? encryKey}) async {
    try {
      late LazyBox<T> box;
      if (Hive.isBoxOpen(boxKey)) {
        box = Hive.lazyBox<T>(boxKey);
      } else {
        box = await Hive.openLazyBox<T>(boxKey,
            encryptionCipher:
                encryKey != null ? HiveAesCipher(encryKey) : null);
      }
      await box.clear();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<T>?> getLazyBoxAllValue<T>(String boxKey,
      {List<int>? encryKey}) async {
    late LazyBox<T> box;
    if (Hive.isBoxOpen(boxKey)) {
      box = Hive.lazyBox<T>(boxKey);
    } else {
      box = await Hive.openLazyBox<T>(boxKey,
          encryptionCipher: encryKey != null ? HiveAesCipher(encryKey) : null);
    }
    List<T> list = [];
    for (var e in box.keys) {
      T? v = await box.get(e);
      if (v != null) {
        list.add(v);
      }
    }
    return Future<List<T>?>.value(list);
  }

  Future<List<T>?> getBoxAllValue<T>(String boxKey,
      {List<int>? encryKey}) async {
    late Box<T> box;
    if (Hive.isBoxOpen(boxKey)) {
      box = Hive.box<T>(boxKey);
    } else {
      box = await Hive.openBox<T>(boxKey,
          encryptionCipher: encryKey != null ? HiveAesCipher(encryKey) : null);
    }
    List<T> list = [];
    for (var e in box.keys) {
      T? v = box.get(e);
      if (v != null) {
        list.add(v);
      }
    }
    return Future<List<T>?>.value(list);
  }
}
