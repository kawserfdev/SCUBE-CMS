import 'package:flutter/material.dart';
import 'package:scubecms/core/constants/app_colors.dart';
import 'package:scubecms/core/constants/app_sizes.dart';

class GradientScrollbar extends StatefulWidget {
  const GradientScrollbar({
    super.key,
    required this.controller,
    required this.child,
    this.thumbHeight = 48,
    this.width = 6,
  });

  final ScrollController controller;
  final Widget child;
  final double thumbHeight;
  final double width;

  @override
  State<GradientScrollbar> createState() => _GradientScrollbarState();
}

class _GradientScrollbarState extends State<GradientScrollbar> {
  double _thumbTop = 0;

  void _updateThumb() {
    if (!mounted || !widget.controller.hasClients) return;

    final position = widget.controller.position;
    final maxScroll = position.maxScrollExtent;
    final viewport = position.viewportDimension;

    if (maxScroll <= 0 || viewport <= widget.thumbHeight) {
      _thumbTop = 0;
    } else {
      _thumbTop =
          (position.pixels / maxScroll) * (viewport - widget.thumbHeight);
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_updateThumb);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateThumb();
    });
  }

  @override
  void didUpdateWidget(covariant GradientScrollbar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_updateThumb);
      widget.controller.addListener(_updateThumb);
      _updateThumb();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateThumb);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.fromLTRB(AppSizes.md, 0.0, 14, AppSizes.md),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          
       widget.child,
          /// Track
          Positioned(
            right: -10,
            top: 8,
            bottom: 8,
            child: Container(
              width: widget.width,
              decoration: BoxDecoration(
                color: AppColors.borderLightBlue.withOpacity(.35),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
      
          /// Thumb
          Positioned(
            right: -10,
            top: 8 + _thumbTop,
            child: IgnorePointer(
              child: Container(
                width: widget.width,
                height: widget.thumbHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4E91FD),
                      Color(0xFF080B7F),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(.35),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
