import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton(
      {required this.onPressed, required this.text, this.icon, super.key});

  final Function onPressed;
  final String text;
  final IconData? icon;

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              widget.onPressed();
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Row(
                    children: [
                      widget.icon == null
                          ? const SizedBox()
                          : Icon(
                              widget.icon,
                              color: Colors.white,
                              size: 18,
                            ),
                      const SizedBox(width: 6.0),
                      Text(
                        widget.text,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )),
      ],
    );
  }
}
