import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/models/employe.dart';
import 'package:sdk/models/post.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/views/admin/employes/employe/router.dart';
import 'package:sdk/xcontroller.dart';

import '../../theme.dart';

class DepartmentController extends XController {
  RxBool rxIsloading = false.obs;
  FocusNode nameNode = FocusNode();
  RxList<Employe> rxEmployes = RxList([]);
  RxList<Post> rxPost = RxList([]);
  Department department;
  DepartmentController(this.department) {
    // loadPosts();
    // loadEmployes();
  }

  TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    // Shop().loadDartpements().then((list) {
    //   rxEmployes.addAll(list as Iterable<Employe>);
    // });
    department.loadPosts().then((list) {
      rxPost.addAll(list);
    });
    super.onInit();
  }

  loadEmployes() {
    rxIsloading.value = true;
    rxEmployes.clear();
    Shop().loadEmployes().then((employes) {
      rxEmployes.addAll(employes);
      rxIsloading.value = false;
    }).catchError((e) {
      rxIsloading.value = false;
    });
  }

  loadPosts() {
    rxIsloading.value = true;
    rxPost.clear();
    department.loadPosts().then((posts) {
      rxPost.addAll(posts);
      rxIsloading.value = false;
    }).catchError((e) {
      rxIsloading.value = false;
    });
  }

  newEmploye(String name) async {
    Employe ep = Employe({'active': true, 'shop': Shop().id, 'name': name});
    if (await ep.save() == true) {
      loadEmployes();
    }
  }

  newPost(String name, Department department) async {
    Post post =
        Post({'active': true, 'shop': Shop().id, 'name': name}, department);

    if (await department.newPost(post) == true) {
      loadPosts();
    }
  }

  setDepartmentValue(String key, dynamic value, Department department) {
    department[key] = value;
    department.save();
    rxEmployes.refresh();
  }
}
