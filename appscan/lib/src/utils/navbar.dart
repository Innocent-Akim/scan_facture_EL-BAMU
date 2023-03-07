import 'package:flutter/material.dart';
import 'UtilsColot.dart';

buildNavbar({size, text, required Icon icon}) {
  return Positioned(
    top: 0,
    child: Container(
      height: size.height * .12,
      width: size.width,
      color: custom_white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      icon,
                      const SizedBox(width: 10),
                      Text(
                        "${text}".toUpperCase(),
                        style: const TextStyle(
                          color: custom_black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
