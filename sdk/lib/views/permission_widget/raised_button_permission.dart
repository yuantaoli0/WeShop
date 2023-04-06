import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/views/request_permission/router.dart';
import 'persmission.dart';

class RaisedButtonPermission extends MaterialButton {
  final XPermission? permission;
  const RaisedButtonPermission({
    Key? key,
    @required this.permission,
    @required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHighlightChanged,
    MouseCursor? mouseCursor,
    ButtonTextTheme? textTheme,
    Color? textColor,
    Color? disabledTextColor,
    Color? color,
    Color? disabledColor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    Brightness? colorBrightness,
    double? elevation,
    double? focusElevation,
    double? hoverElevation,
    double? highlightElevation,
    double? disabledElevation,
    EdgeInsetsGeometry? padding,
    VisualDensity? visualDensity,
    ShapeBorder? shape,
    Clip clipBehavior = Clip.none,
    FocusNode? focusNode,
    bool autofocus = false,
    MaterialTapTargetSize? materialTapTargetSize,
    Duration? animationDuration,
    Widget? child,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(focusElevation == null || focusElevation >= 0.0),
        assert(hoverElevation == null || hoverElevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0),
        super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHighlightChanged: onHighlightChanged,
          mouseCursor: mouseCursor,
          textTheme: textTheme,
          textColor: textColor,
          disabledTextColor: disabledTextColor,
          color: color,
          disabledColor: disabledColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorBrightness: colorBrightness,
          elevation: elevation,
          focusElevation: focusElevation,
          hoverElevation: hoverElevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          padding: padding,
          visualDensity: visualDensity,
          shape: shape,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          animationDuration: animationDuration,
          child: child,
        );
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ButtonThemeData buttonTheme = ButtonTheme.of(context);
    VoidCallback? onPressed = this.onPressed;
    //if (kReleaseMode) {
    if (this.onPressed != null) {
      onPressed = () async {
        if (User.currentUser?.canAccess(permission!.url) == false) {
          var r = await RequestPermissionRouter().gotoName('/requestPermission', args: {'permission': permission});
          if (r == true) {
            this.onPressed!();
          }
        } else {
          this.onPressed!();
        }
      };
    }
    //}
    if (permission?.isPermission == false || User.currentUser?.hasPermission(permission!.url) == false) {
      return const SizedBox.shrink();
    } else {
      return RawMaterialButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHighlightChanged: onHighlightChanged,
        mouseCursor: mouseCursor,
        clipBehavior: clipBehavior,
        fillColor: buttonTheme.getFillColor(this),
        textStyle: theme.textTheme.button?.copyWith(color: buttonTheme.getTextColor(this)),
        focusColor: buttonTheme.getFocusColor(this),
        hoverColor: buttonTheme.getHoverColor(this),
        highlightColor: buttonTheme.getHighlightColor(this),
        splashColor: buttonTheme.getSplashColor(this),
        elevation: buttonTheme.getElevation(this),
        focusElevation: buttonTheme.getFocusElevation(this),
        hoverElevation: buttonTheme.getHoverElevation(this),
        highlightElevation: buttonTheme.getHighlightElevation(this),
        disabledElevation: buttonTheme.getDisabledElevation(this),
        padding: buttonTheme.getPadding(this),
        visualDensity: visualDensity ?? theme.visualDensity,
        constraints: buttonTheme.getConstraints(this),
        shape: buttonTheme.getShape(this),
        focusNode: focusNode,
        autofocus: autofocus,
        animationDuration: buttonTheme.getAnimationDuration(this),
        materialTapTargetSize: buttonTheme.getMaterialTapTargetSize(this),
        child: child,
      );
    }
  }
}
