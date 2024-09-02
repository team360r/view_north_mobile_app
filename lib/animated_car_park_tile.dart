import 'package:flutter/material.dart';
import 'package:view_north_app/models/car_park.dart';

class AnimatedCarParkTile extends StatefulWidget {
  final StaticCarPark carPark;

  const AnimatedCarParkTile({required this.carPark});

  @override
  _AnimatedCarParkTileState createState() => _AnimatedCarParkTileState();
}

class _AnimatedCarParkTileState extends State<AnimatedCarParkTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  // Variables to track previous values
  num _previousAvailableSpaces = 0;
  String _previousStatus = '';

  @override
  void initState() {
    super.initState();

    // Initialize previous values with the current ones, defaulting if necessary
    _previousAvailableSpaces = widget.carPark.availableSpaces ?? 0;
    _previousStatus = widget.carPark.status ?? '';

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.yellow[100],
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(AnimatedCarParkTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Get the new values or default to 0 or empty string if null
    final newAvailableSpaces = widget.carPark.availableSpaces ?? 0;
    final newStatus = widget.carPark.status ?? '';

    // Detect if the availableSpaces or status has changed
    if (newAvailableSpaces != _previousAvailableSpaces ||
        newStatus != _previousStatus) {
      _previousAvailableSpaces = newAvailableSpaces;
      _previousStatus = newStatus;

      // Trigger the animation
      _controller.forward().then((_) {
        _controller.reverse();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          color: _colorAnimation.value,
          child: ListTile(
            title: Text(widget.carPark.name ?? 'Unknown'),
            subtitle: Text(
                '${widget.carPark.address ?? 'No Address'}\nStatus: ${widget.carPark.status ?? 'Unknown'}'),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Capacity: ${widget.carPark.capacity ?? 0}'),
                Text('Available: ${widget.carPark.availableSpaces ?? 0}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
