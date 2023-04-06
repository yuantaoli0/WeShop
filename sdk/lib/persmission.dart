import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'xlocal.dart';

typedef AskPermissionCallback = Future<bool> Function();
enum XPermissionType {
  hide,
}

abstract class XPermission {
  String name;
  double value;
  bool askLocalAuth;
  bool isPermission = true;
  XPermission? parent;
  List<XPermission> _children = [];

  String get url {
    if (parent == null) {
      return name;
    } else {
      return parent!.url + '/' + name;
    }
  }

  String get displayName {
    if (parent == null) {
      return (local.name + name).tr;
    } else {
      return parent!.displayName + '/' + (local.name + name).tr;
    }
  }

  List<XPermission> spread() {
    List<XPermission> permissions = [];

    for (var p in _children) {
      permissions.add(p);
      permissions.addAll(p.spread());
    }

    return permissions;
  }

  addChild(XPermission p) {
    _children.add(p);
  }

  XPermission(this.name, this.value, this.isPermission, {this.askLocalAuth = false, this.parent});

  XBaseLocal get local;
}
