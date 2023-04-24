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
  RxBool isTextFieldEditable = false.obs;
  FocusNode nameNode = FocusNode();
  FocusNode postnameNode = FocusNode();
  RxList<Employe> rxEmployes = RxList([]);
  RxList<Post> rxPost = RxList([]);
  Department department;
  DepartmentController(this.department);

  TextEditingController nameController = TextEditingController();
  TextEditingController postnameController = TextEditingController();

  final editablePostId = RxString('');

  // void toggle() {
  //   isTextFieldEditable.value = !isTextFieldEditable.value;
  // }
  

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

  loadPosts(Department department) {
    rxIsloading.value = true;
    rxPost.clear();
    department.loadPosts().then((posts) {
      rxPost.addAll(posts);
      rxIsloading.value = false;
    }).catchError((e) {
      rxIsloading.value = false;
    });
  }

  delPosts(Post post) async {
    if (await XController.getConfirm(
            title: 'Confirmation', content: 'Vous etes sur?') ==
        true) {
      await post.del();
      rxPost.remove(post);
    }
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
      loadPosts(department);
    }
  }

  setDepartmentValue(String key, dynamic value, Department department) {
    department[key] = value;
    department.save();
    rxEmployes.refresh();
  }

  setPostValue(String key, dynamic value, Post post) {
    post[key] = value;
    post.save();
    rxPost.refresh();
  }
}
