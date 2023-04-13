import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomStack extends Stack {
  CustomStack({
    super.key,
    super.clipBehavior,
    super.alignment,
    super.children,
    super.fit,
    super.textDirection,
  });

  @override
  RenderStack createRenderObject(BuildContext context) {
    return CustomRenderStack(
      alignment: alignment,
      clipBehavior: clipBehavior,
      fit: fit,
    );
  }
}

class CustomRenderStack extends RenderStack {
  CustomRenderStack({
    super.alignment,
    super.children,
    super.clipBehavior,
    super.fit,
  });

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (hitTestChildren(result, position: position)) {}
    return super.hitTest(result, position: position);
  }
}
