// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:my_chips/config/styles.dart';
// import 'package:my_chips/features/unused/custom_auto_complete.dart';
// import 'package:my_chips/features/chip/view/widgets/selected_builder.dart';
// import 'package:my_chips/features/unused/suggestion_builder.dart';
// import 'package:my_chips/features/chip/view_model/chip_view_model.dart';
// import 'package:provider/provider.dart';

// class ChipView<T extends ChipViewModel> extends StatefulWidget {
//   const ChipView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<ChipView<T>> createState() => _ChipViewState<T>();
// }

// class _ChipViewState<T extends ChipViewModel> extends State<ChipView<T>> {
//   late final ScrollController _scrollController;

//   @override
//   void initState() {
//     _scrollController = ScrollController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<T>(
//       builder: (context, value, child) {
//         return CustomAutoComplete(
//           onSelected: (entry) {
//             log('selected');
//             if (entry.mounted) {
//               entry.remove();
//             }
//           },
//           onFocusChanged: (focusNode, entry) {
//             log('hasFocus : ${focusNode.hasFocus}');
//             if (focusNode.hasFocus) {
//               if (!entry.mounted) {
//                 Overlay.of(context).insert(entry);
//               }
//             }
//           },
//           overlayHeight: 120,
//           showOverlay: () => value.isFocused,
//           overlayBuilder: (context, entry, onSelected, focusNode) {
//             return Material(
//               child: Center(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: defaultPadding),
//                     child: Wrap(
//                       clipBehavior: Clip.hardEdge,
//                       children: value.nonSelected
//                           .map(
//                             (e) => Padding(
//                               padding: const EdgeInsets.all(2),
//                               child: InkWell(
//                                 onTap: () {
//                                   value.selectedEvent(e);
//                                   focusNode.requestFocus();
//                                 },
//                                 child: Chip(
//                                   label: Text(e.value),
//                                 ),
//                               ),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//           fieldBuilder: (context, focusNode, controller) {
//             return Container(
//               padding: const EdgeInsets.symmetric(
//                 vertical: defaultPadding * 0.2,
//               ),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//                 borderRadius: BorderRadius.circular(defaultRadius),
//               ),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 controller: _scrollController,
//                 child: Row(
//                   children: [
//                     SelectedBuilder<T>(),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: RawKeyboardListener(
//                         onKey: (keyEvent) {
//                           if (keyEvent.isKeyPressed(
//                             LogicalKeyboardKey.backspace,
//                           )) {
//                             if (controller.text.isEmpty &&
//                                 value.selected.isNotEmpty) {
//                               value.removeEvent(value.selected.last);
//                             }
//                           }
//                         },
//                         focusNode: focusNode,
//                         child: TextFormField(
//                           decoration: const InputDecoration(
//                             isDense: true,
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
