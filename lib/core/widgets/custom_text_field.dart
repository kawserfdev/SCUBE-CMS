// import 'package:flutter/material.dart';

// import '../constants/app_sizes.dart';

// class CustomTextField extends StatelessWidget {
//   const CustomTextField({
//     super.key,
//     this.hintText,
//     this.prefixIcon,
//     this.controller,
//     this.onChanged,
//   });

//   final String? hintText;
//   final IconData? prefixIcon;
//   final TextEditingController? controller;
//   final ValueChanged<String>? onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         hintText: hintText,
//         prefixIcon: prefixIcon != null
//             ? Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
//                 child: Icon(prefixIcon, size: AppSizes.iconSize),
//               )
//             : null,
//         prefixIconConstraints: const BoxConstraints(
//           maxHeight: AppSizes.iconSize + AppSizes.md * 2,
//         ),
//       ),
//     );
//   }
// }
