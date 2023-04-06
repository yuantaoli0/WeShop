import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/persmission.dart';
import 'package:sdk/views/request_permission/router.dart';

const bool _kCloseOnTap = true;

class SlideActionPermission extends SlidableAction {
  final XPermission? permission;
  SlideActionPermission({
    @required this.permission,
    Key? key,
    IconData? icon,
    String? caption,
    Color color = Colors.white,
    Color? foregroundColor,
    VoidCallback? onTap,
    bool autoClose = _kCloseOnTap,
  })  : assert(icon != null, 'Either set icon or iconWidget.'),
        super(
          key: key,
          icon: icon,
          label: caption,
          backgroundColor: color,
          foregroundColor: foregroundColor,
          onPressed: User.currentUser?.canAccess(permission!.url) == false
              ? (ctx) async {
                  var r = await RequestPermissionRouter().gotoName('/requestPermission', args: {'permission': permission});
                  if (r == true) {
                    onTap!();
                  }
                }
              : (ctx) => onTap!(),
          autoClose: autoClose,
        ) {
    /*if (permission != null) {
      var old = onTap;
      if (old != null) {
        this.onTap = () async {
          if (User.currentUser.canAccess(permission.url) == false) {
            var r = await RequestPermissionRouter().gotoName('/requestPermission', args: {'permission': permission});
            if (r == true) {
              old();
            }
          } else {
            old();
          }
        };
        if (permission == null || User.currentUser.hasPermission(permission.url) == false) {
          child = SizedBox.shrink();
        }
      } else {
        child = Container(
          color: Colors.grey.withOpacity(0.8),
          child: child,
        );
      }
    } else {
      child = Container();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    if (permission?.isPermission == false || User.currentUser?.hasPermission(permission!.url) == false) {
      return const SizedBox.shrink();
    } else {
      return super.build(context);
    }
  }
}
