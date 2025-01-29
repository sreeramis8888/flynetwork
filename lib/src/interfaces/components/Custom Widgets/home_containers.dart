import 'package:flutter/material.dart';
import 'package:flynetwork/src/data/services/snackbar_service.dart';

class HomeContainers extends StatefulWidget {
  final IconData icon;
  final Color backgroundColor;
  final double size;
  final Color iconColor;
  final String title;
  final VoidCallback? onTap;
  const HomeContainers({
    super.key,
    required this.icon,
    this.backgroundColor = const Color(0xFFFFFDD6),
    this.size = 56.0,
    this.iconColor = const Color(0xFF968F00),
    required this.title,
    this.onTap,
  });

  @override
  State<HomeContainers> createState() => _HomeContainersState();
}

class _HomeContainersState extends State<HomeContainers>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Subtle fade in
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    // Subtle slide up
    _slideAnimation = Tween<double>(
      begin: 15.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1, curve: Curves.easeOut),
    ));

    // Start animation with a minimal delay
    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          InkWell(
            onTap: () => widget.onTap!(),
            child: Container(
              height: widget.size,
              width: widget.size,
              decoration: BoxDecoration(
                border: Border.all(color: widget.iconColor),
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                // Add subtle shadow for depth
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  widget.icon,
                  color: widget.iconColor,
                  size: widget.size * 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 30, // Fixed height for text to ensure alignment
            child: Center(
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
