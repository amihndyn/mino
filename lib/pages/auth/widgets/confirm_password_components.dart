import 'package:flutter/material.dart';

class MockStatusBar extends StatelessWidget {
  const MockStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        margin: const EdgeInsets.only(bottom: 410, left: 20, right: 20),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40,
              height: 13,
              child: Image.network(
                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/6xlrx1RpIF/zepxfix6_expires_30_days.png",
                fit: BoxFit.fill,
              ),
            ),
            IntrinsicWidth(
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 18,
                      height: 12,
                      child: Image.network(
                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/6xlrx1RpIF/n1ijmj73_expires_30_days.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 18,
                      height: 12,
                      child: Image.network(
                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/6xlrx1RpIF/906akcxs_expires_30_days.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 28,
                      height: 13,
                      child: Image.network(
                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/6xlrx1RpIF/d17xlgsx_expires_30_days.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PinIconRow extends StatelessWidget {
  const PinIconRow({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Container(
          margin: const EdgeInsets.only(bottom: 441),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 35,
                height: 35,
                child: Image.network(
                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/6xlrx1RpIF/6fw88u45_expires_30_days.png",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 35,
                height: 35,
                child: Image.network(
                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/6xlrx1RpIF/uxwvcd8z_expires_30_days.png",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 35,
                height: 35,
                child: Image.network(
                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/6xlrx1RpIF/iafsj5je_expires_30_days.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: 35,
                height: 35,
                child: Image.network(
                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/6xlrx1RpIF/lezkyxcc_expires_30_days.png",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}