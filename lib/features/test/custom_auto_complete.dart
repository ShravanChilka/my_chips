import 'package:flutter/material.dart';

typedef CustomFieldViewBuilder = Widget Function(
  BuildContext context,
  TextEditingController controller,
  FocusNode focusNode,
);

typedef CustomOptionViewBuilder<T extends Object?> = Widget Function(
  BuildContext context,
  T onSelected,
  FocusNode focusNode,
);

class CustomAutoComplete<T extends Object?> extends StatefulWidget {
  final double optionsMaxHeight;
  final void Function(T selectedItem)? onSelected;
  final CustomFieldViewBuilder fieldViewBuilder;
  const CustomAutoComplete({
    Key? key,
    this.optionsMaxHeight = 200,
    required this.onSelected,
    required this.fieldViewBuilder,
  }) : super(key: key);

  @override
  State<CustomAutoComplete<T>> createState() => _CustomAutoCompleteState<T>();
}

class _CustomAutoCompleteState<T extends Object?>
    extends State<CustomAutoComplete<T>> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
