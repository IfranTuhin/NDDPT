import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {
  final bool initialSwitchState;
  final String buttontext;
  final String imageFirst;
  final String imageSecond;
  final ValueChanged<bool> onToggle;

  CustomToggle({
    required this.initialSwitchState,
    required this.buttontext,
    required this.imageFirst,
    required this.imageSecond,
    required this.onToggle,
  });

  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  late bool _isSwitched;

  @override
  void initState() {
    super.initState();
    _isSwitched = widget.initialSwitchState;
  }

  void _toggleSwitch() {
    setState(() {
      _isSwitched = !_isSwitched;
    });
    widget.onToggle(_isSwitched); // Notify parent widget of the change
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _toggleSwitch, // Toggle switch when tapped
        child: Container(
          width: 50,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: _isSwitched ? const Color(0xff2B68C5) : const Color(0xffE6E0E9),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                left: _isSwitched ? 20 : 0,
                right: _isSwitched ? 0 : 20,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: _isSwitched
                          ? AssetImage(widget.imageFirst)
                          : AssetImage(widget.imageSecond),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
