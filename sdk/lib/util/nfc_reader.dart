import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import "package:hex/hex.dart";
import 'package:nfc_manager/nfc_manager.dart';

class NFCReader {
  static final NFCReader instance = NFCReader._();
  NFCReader._() {
    if (Platform.isAndroid) {
      NfcManager.instance.isAvailable().then((availability) {
        if (availability == true) {
          NfcManager.instance.startSession(
            onDiscovered: (NfcTag tag) async {
              if (tag.data['nfca'] != null && tag.data['nfca']['identifier'] != null) {
                var uid = HEX.encode(tag.data['nfca']['identifier'].reversed.toList());
                //uid = String.fromCharCodes(uid.runes.toList().reversed);
                uid = int.tryParse(uid, radix: 16).toString();
                uid = uid.padLeft(10, '0');
                for (final ValueChanged<XNFCValueEvent> listener in List<ValueChanged<XNFCValueEvent>>.from(_listeners)) {
                  if (_listeners.contains(listener)) {
                    listener(XNFCValueEvent(uid));
                  }
                }
              }
              // Do something with an NfcTag instance.
            },
          );
        }
      });
    }
  }

  final List<ValueChanged<XNFCValueEvent>> _listeners = <ValueChanged<XNFCValueEvent>>[];
  void addListener(ValueChanged<XNFCValueEvent> listener) {
    _listeners.add(listener);
  }

  /// Stop calling the given listener every time the user presses or releases a
  /// hardware keyboard key.
  ///
  /// Listeners can be added with [addListener].
  void removeListener(ValueChanged<XNFCValueEvent> listener) {
    _listeners.remove(listener);
  }
}

class XNFCValueEvent {
  final String uid;
  XNFCValueEvent(this.uid);
}
