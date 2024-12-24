import 'package:flutter/material.dart';

class Centerlist extends StatelessWidget {
  final IconData leftIcon;
  final String str;
  final VoidCallback ontap;
  const Centerlist({
    super.key,
    required this.leftIcon,
    required this.str,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       
        onTap:  ontap,
         child: Container(
          padding: EdgeInsets.only(bottom: 10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromARGB(121, 189, 177, 177)))),
          child: Row(
            children: [
              Icon(leftIcon,color: const Color.fromARGB(102, 0, 238, 255),),
              const SizedBox(
                width: 7,
                
              ),
              Expanded(
                  child: Text(
                str,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color.fromARGB(250, 0, 0, 0),
                ),
              )),
              const Icon(
                Icons.chevron_right,
                size: 16,
              ),
            ],
          ),
        ),
        );
  }
}
