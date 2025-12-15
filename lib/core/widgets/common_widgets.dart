// import 'package:flutter/material.dart';

// import '../constants/app_sizes.dart';

// class SectionHeader extends StatelessWidget {
//   const SectionHeader({
//     super.key,
//     required this.title,
//     this.actionLabel,
//     this.onActionTap,
//   });

//   final String title;
//   final String? actionLabel;
//   final VoidCallback? onActionTap;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: Theme.of(
//             context,
//           ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//         ),
//         if (actionLabel != null)
//           TextButton(
//             onPressed: onActionTap,
//             style: TextButton.styleFrom(
//               foregroundColor: Theme.of(context).colorScheme.primary,
//             ),
//             child: Text(actionLabel!),
//           ),
//       ],
//     );
//   }
// }

// class FilterChipBar extends StatelessWidget {
//   const FilterChipBar({
//     super.key,
//     required this.labels,
//     required this.selectedIndex,
//     required this.onSelected,
//   });

//   final List<String> labels;
//   final int selectedIndex;
//   final ValueChanged<int> onSelected;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 36,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: labels.length,
//         separatorBuilder: (_, __) => const SizedBox(width: AppSizes.md),
//         itemBuilder: (context, index) {
//           final bool isSelected = index == selectedIndex;
//           return ChoiceChip(
//             label: Text(labels[index]),
//             selected: isSelected,
//             onSelected: (_) => onSelected(index),
//             selectedColor: Theme.of(
//               context,
//             ).colorScheme.primary.withOpacity(0.15),
//             labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
//               color: isSelected
//                   ? Theme.of(context).colorScheme.primary
//                   : Theme.of(context).colorScheme.onSurface,
//               fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(AppSizes.cardRadius),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
//           );
//         },
//       ),
//     );
//   }
// }
