import 'package:flutter/material.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/views/request_permission/router.dart';
import 'dart:math' as math;

import 'persmission.dart';

const double _kMinButtonSize = kMinInteractiveDimension;

class IconButtonPermission extends IconButton {
  final XPermission? permission;
  const IconButtonPermission({
    Key? key,
    double iconSize = 24.0,
    VisualDensity? visualDensity,
    padding = const EdgeInsets.all(8.0),
    alignment = Alignment.center,
    double? splashRadius,
    Widget icon = const SizedBox.shrink(),
    Color? color,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    Color? disabledColor,
    @required this.permission,
    @required VoidCallback? onPressed,
    mouseCursor = SystemMouseCursors.click,
    FocusNode? focusNode,
    autofocus = false,
    String? tooltip,
    enableFeedback = true,
    BoxConstraints? constraints,
  })  : assert(padding != null),
        assert(alignment != null),
        assert(splashRadius == null || splashRadius > 0),
        assert(autofocus != null),
        super(
            key: key,
            iconSize: iconSize,
            visualDensity: visualDensity,
            padding: padding,
            alignment: alignment,
            splashRadius: splashRadius,
            icon: icon,
            color: color,
            focusColor: focusColor,
            hoverColor: hoverColor,
            highlightColor: highlightColor,
            splashColor: splashColor,
            disabledColor: disabledColor,
            onPressed: onPressed,
            mouseCursor: mouseCursor,
            focusNode: focusNode,
            autofocus: autofocus,
            tooltip: tooltip,
            enableFeedback: enableFeedback,
            constraints: constraints);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData theme = Theme.of(context);
    Color? currentColor;
    VoidCallback? onPressed = this.onPressed;
    if (onPressed != null) {
      currentColor = color;
    } else {
      currentColor = disabledColor ?? theme.disabledColor;
    }

    final VisualDensity effectiveVisualDensity = visualDensity ?? theme.visualDensity;

    final BoxConstraints unadjustedConstraints = constraints ??
        const BoxConstraints(
          minWidth: _kMinButtonSize,
          minHeight: _kMinButtonSize,
        );
    final BoxConstraints adjustedConstraints = effectiveVisualDensity.effectiveConstraints(unadjustedConstraints);

    Widget result = ConstrainedBox(
      constraints: adjustedConstraints,
      child: Padding(
        padding: padding,
        child: SizedBox(
          height: iconSize,
          width: iconSize,
          child: Align(
            alignment: alignment,
            child: IconTheme.merge(
              data: IconThemeData(
                size: iconSize,
                color: currentColor,
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      result = Tooltip(
        message: tooltip!,
        child: result,
      );
    }

    //if (kReleaseMode) {
    if (this.onPressed != null) {
      onPressed = () async {
        if (User.currentUser!.canAccess(permission!.url) == false) {
          var r = await RequestPermissionRouter().gotoName('/requestPermission', args: {'permission': permission});
          if (r == true) {
            this.onPressed!();
          }
        } else {
          this.onPressed!();
        }
      };
    }
    if (permission?.isPermission == false || User.currentUser!.hasPermission(permission!.url) == false) {
      return const SizedBox.shrink();
    } else {
      return Semantics(
        button: true,
        enabled: onPressed != null,
        child: InkResponse(
          focusNode: focusNode,
          autofocus: autofocus,
          canRequestFocus: onPressed != null,
          onTap: onPressed,
          mouseCursor: mouseCursor,
          enableFeedback: enableFeedback,
          focusColor: focusColor ?? theme.focusColor,
          hoverColor: hoverColor ?? theme.hoverColor,
          highlightColor: highlightColor ?? theme.highlightColor,
          splashColor: splashColor ?? theme.splashColor,
          radius: splashRadius ??
              math.max(
                Material.defaultSplashRadius,
                (iconSize! + math.min(padding.horizontal, padding.vertical)) * 0.7,
                // x 0.5 for diameter -> radius and + 40% overflow derived from other Material apps.
              ),
          child: result,
        ),
      );
    }
  }
}
