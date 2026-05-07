import 'package:mino/theme/tokens.dart';
import 'package:flutter/material.dart';

class SuggestWords extends StatelessWidget {
  const SuggestWords({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 268.7,
      height: 19.1,
      child: Flex(
        spacing: 94.39999999999964,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        direction: Axis.horizontal,
        children: [
          const SizedBox(
            width: 40.8,
            height: 19.1,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.topCenter,
              child: Text(
                'Yes',
                style: TextStyle(
                  fontSize: 19.8,
                  fontFamily: 'Inter',
                  height: 0.96,
                  color: orange100,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: 11.7,
            height: 19.1,
            padding: const EdgeInsets.only(right: 5.700000000000728),
            alignment: AlignmentDirectional.topStart,
            child: const SizedBox(
              width: 6,
              height: 19.1,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topLeft,
                child: Text(
                  'I',
                  style: TextStyle(
                    fontSize: 19.8,
                    fontFamily: 'Inter',
                    height: 0.96,
                    color: orange100,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 28,
            height: 19.1,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.topLeft,
              child: Text(
                'I’m',
                style: TextStyle(
                  fontSize: 19.8,
                  fontFamily: 'Inter',
                  height: 0.96,
                  color: orange100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}