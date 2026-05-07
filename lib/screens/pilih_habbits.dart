import 'package:flutter/material.dart';

class PilihHabit extends StatefulWidget {
  const PilihHabit({super.key});
  @override
  PilihHabitState createState() => PilihHabitState();
}

class PilihHabitState extends State<PilihHabit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/lzn769sn_expires_30_days.png",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            width: double.infinity,
                            height: double.infinity,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(top: 17),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IntrinsicHeight(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24),
                                        ),
                                      ),
                                      margin: const EdgeInsets.only(
                                        bottom: 64,
                                        left: 20,
                                        right: 20,
                                      ),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 13,
                                            child: Image.network(
                                              "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/wnp6f1rq_expires_30_days.png",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          IntrinsicWidth(
                                            child: IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                          right: 8,
                                                        ),
                                                    width: 18,
                                                    height: 12,
                                                    child: Image.network(
                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/2t9zwgwp_expires_30_days.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                          right: 8,
                                                        ),
                                                    width: 18,
                                                    height: 12,
                                                    child: Image.network(
                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/l3sdr141_expires_30_days.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 28,
                                                    height: 13,
                                                    child: Image.network(
                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/hvuebuqb_expires_30_days.png",
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
                                  ),
                                  IntrinsicHeight(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Color(0xFFE6A84A),
                                      ),
                                      padding: const EdgeInsets.only(top: 44),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          IntrinsicHeight(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                bottom: 34,
                                                left: 29,
                                                right: 29,
                                              ),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 55,
                                                    height: 24,
                                                    child: SizedBox(),
                                                  ),
                                                  Text(
                                                    "Add Habit",
                                                    style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      color: Color(0xFFA7A7A7),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          IntrinsicHeight(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                bottom: 76,
                                                left: 20,
                                                right: 44,
                                              ),
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                          bottom: 9,
                                                        ),
                                                    child: Text(
                                                      "Let’s discover your new habits",
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF000000,
                                                        ),
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Choose one habit, then tap Next",
                                                    style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          IntrinsicHeight(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                bottom: 26,
                                                left: 20,
                                                right: 20,
                                              ),
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                          bottom: 8,
                                                        ),
                                                    child: Text(
                                                      "Jadilah unik",
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF000000,
                                                        ),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  IntrinsicHeight(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        color: Color(
                                                          0xFFE6A84A,
                                                        ),
                                                      ),
                                                      width: double.infinity,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          IntrinsicWidth(
                                                            child: IntrinsicHeight(
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    margin:
                                                                        const EdgeInsets.only(
                                                                          right:
                                                                              12,
                                                                        ),
                                                                    width: 53,
                                                                    height: 53,
                                                                    child: Image.network(
                                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/6wp08wil_expires_30_days.png",
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Ciptakan kebiasaan khusus",
                                                                    style: TextStyle(
                                                                      color: Color(
                                                                        0xFF6F6F6F,
                                                                      ),
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        12,
                                                                      ),
                                                                ),
                                                            margin:
                                                                const EdgeInsets.only(
                                                                  right: 13,
                                                                ),
                                                            width: 24,
                                                            height: 24,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    12,
                                                                  ),
                                                              child: Image.network(
                                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/zz95ccsi_expires_30_days.png",
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          IntrinsicWidth(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  bottom: 26,
                                                  left: 20,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            bottom: 8,
                                                            right: 112,
                                                          ),
                                                      child: Text(
                                                        "Lakukan perawatan diri",
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFF000000,
                                                          ),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    IntrinsicWidth(
                                                      child: IntrinsicHeight(
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                print(
                                                                  'Pressed',
                                                                );
                                                              },
                                                              child: IntrinsicWidth(
                                                                child: IntrinsicHeight(
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            12,
                                                                          ),
                                                                      color: Color(
                                                                        0xFFFFF7EC,
                                                                      ),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.only(
                                                                          top:
                                                                              4,
                                                                          bottom:
                                                                              4,
                                                                          left:
                                                                              8,
                                                                          right:
                                                                              8,
                                                                        ),
                                                                    margin:
                                                                        const EdgeInsets.only(
                                                                          right:
                                                                              8,
                                                                        ),
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          margin: const EdgeInsets.only(
                                                                            right:
                                                                                4,
                                                                          ),
                                                                          width:
                                                                              39,
                                                                          height:
                                                                              37,
                                                                          child: Image.network(
                                                                            "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/pdoniafc_expires_30_days.png",
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "Mandi",
                                                                          style: TextStyle(
                                                                            color: Color(
                                                                              0xFF000000,
                                                                            ),
                                                                            fontSize:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                print(
                                                                  'Pressed',
                                                                );
                                                              },
                                                              child: IntrinsicWidth(
                                                                child: IntrinsicHeight(
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            12,
                                                                          ),
                                                                      color: Color(
                                                                        0xFFFFF7EC,
                                                                      ),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.only(
                                                                          top:
                                                                              4,
                                                                          bottom:
                                                                              4,
                                                                          left:
                                                                              12,
                                                                          right:
                                                                              12,
                                                                        ),
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          margin: const EdgeInsets.only(
                                                                            right:
                                                                                4,
                                                                          ),
                                                                          width:
                                                                              39,
                                                                          height:
                                                                              37,
                                                                          child: Image.network(
                                                                            "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/9bs70dme_expires_30_days.png",
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "rawat rambut",
                                                                          style: TextStyle(
                                                                            color: Color(
                                                                              0xFF000000,
                                                                            ),
                                                                            fontSize:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          IntrinsicWidth(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  bottom: 26,
                                                  left: 20,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            bottom: 8,
                                                            right: 248,
                                                          ),
                                                      child: Text(
                                                        "Menjadi aktif",
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFF000000,
                                                          ),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    IntrinsicWidth(
                                                      child: IntrinsicHeight(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            IntrinsicWidth(
                                                              child: IntrinsicHeight(
                                                                child: Container(
                                                                  margin:
                                                                      const EdgeInsets.only(
                                                                        bottom:
                                                                            8,
                                                                        right:
                                                                            33,
                                                                      ),
                                                                  child: Row(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: () {
                                                                          print(
                                                                            'Pressed',
                                                                          );
                                                                        },
                                                                        child: IntrinsicWidth(
                                                                          child: IntrinsicHeight(
                                                                            child: Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(
                                                                                  12,
                                                                                ),
                                                                                color: Color(
                                                                                  0xFFFFF7EC,
                                                                                ),
                                                                              ),
                                                                              padding: const EdgeInsets.only(
                                                                                top: 4,
                                                                                bottom: 4,
                                                                                left: 12,
                                                                                right: 12,
                                                                              ),
                                                                              margin: const EdgeInsets.only(
                                                                                right: 8,
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    margin: const EdgeInsets.only(
                                                                                      right: 4,
                                                                                    ),
                                                                                    width: 39,
                                                                                    height: 37,
                                                                                    child: Image.network(
                                                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/ky3kmjqw_expires_30_days.png",
                                                                                      fit: BoxFit.fill,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    "Latihan yoga",
                                                                                    style: TextStyle(
                                                                                      color: Color(
                                                                                        0xFF000000,
                                                                                      ),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        onTap: () {
                                                                          print(
                                                                            'Pressed',
                                                                          );
                                                                        },
                                                                        child: IntrinsicWidth(
                                                                          child: IntrinsicHeight(
                                                                            child: Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(
                                                                                  12,
                                                                                ),
                                                                                color: Color(
                                                                                  0xFFFFF7EC,
                                                                                ),
                                                                              ),
                                                                              padding: const EdgeInsets.only(
                                                                                top: 4,
                                                                                bottom: 4,
                                                                                left: 12,
                                                                                right: 12,
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    margin: const EdgeInsets.only(
                                                                                      right: 4,
                                                                                    ),
                                                                                    width: 39,
                                                                                    height: 37,
                                                                                    child: Image.network(
                                                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/z09afjc1_expires_30_days.png",
                                                                                      fit: BoxFit.fill,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    "Pergi gym",
                                                                                    style: TextStyle(
                                                                                      color: Color(
                                                                                        0xFF000000,
                                                                                      ),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            IntrinsicWidth(
                                                              child: IntrinsicHeight(
                                                                child: Row(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap: () {
                                                                        print(
                                                                          'Pressed',
                                                                        );
                                                                      },
                                                                      child: IntrinsicWidth(
                                                                        child: IntrinsicHeight(
                                                                          child: Container(
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(
                                                                                12,
                                                                              ),
                                                                              color: Color(
                                                                                0xFFFFF7EC,
                                                                              ),
                                                                            ),
                                                                            padding: const EdgeInsets.only(
                                                                              top: 4,
                                                                              bottom: 4,
                                                                              left: 12,
                                                                              right: 12,
                                                                            ),
                                                                            margin: const EdgeInsets.only(
                                                                              right: 8,
                                                                            ),
                                                                            child: Row(
                                                                              children: [
                                                                                Container(
                                                                                  margin: const EdgeInsets.only(
                                                                                    right: 4,
                                                                                  ),
                                                                                  width: 39,
                                                                                  height: 37,
                                                                                  child: Image.network(
                                                                                    "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/idfwxyl4_expires_30_days.png",
                                                                                    fit: BoxFit.fill,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  "Jalan 10.000 langkah",
                                                                                  style: TextStyle(
                                                                                    color: Color(
                                                                                      0xFF000000,
                                                                                    ),
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap: () {
                                                                        print(
                                                                          'Pressed',
                                                                        );
                                                                      },
                                                                      child: IntrinsicWidth(
                                                                        child: IntrinsicHeight(
                                                                          child: Container(
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(
                                                                                12,
                                                                              ),
                                                                              color: Color(
                                                                                0xFFFFF7EC,
                                                                              ),
                                                                            ),
                                                                            padding: const EdgeInsets.only(
                                                                              top: 4,
                                                                              bottom: 4,
                                                                              left: 12,
                                                                              right: 12,
                                                                            ),
                                                                            child: Row(
                                                                              children: [
                                                                                Container(
                                                                                  margin: const EdgeInsets.only(
                                                                                    right: 4,
                                                                                  ),
                                                                                  width: 39,
                                                                                  height: 37,
                                                                                  child: Image.network(
                                                                                    "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/urw7xnp8_expires_30_days.png",
                                                                                    fit: BoxFit.fill,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  "Pilates",
                                                                                  style: TextStyle(
                                                                                    color: Color(
                                                                                      0xFF000000,
                                                                                    ),
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          IntrinsicWidth(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  bottom: 26,
                                                  left: 20,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            bottom: 8,
                                                            right: 205,
                                                          ),
                                                      child: Text(
                                                        "Jadilah lebih sehat",
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFF000000,
                                                          ),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    IntrinsicWidth(
                                                      child: IntrinsicHeight(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            IntrinsicWidth(
                                                              child: IntrinsicHeight(
                                                                child: Container(
                                                                  margin:
                                                                      const EdgeInsets.only(
                                                                        bottom:
                                                                            8,
                                                                        right:
                                                                            33,
                                                                      ),
                                                                  child: Row(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: () {
                                                                          print(
                                                                            'Pressed',
                                                                          );
                                                                        },
                                                                        child: IntrinsicWidth(
                                                                          child: IntrinsicHeight(
                                                                            child: Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(
                                                                                  12,
                                                                                ),
                                                                                color: Color(
                                                                                  0xFFFFF7EC,
                                                                                ),
                                                                              ),
                                                                              padding: const EdgeInsets.only(
                                                                                top: 4,
                                                                                bottom: 4,
                                                                                left: 12,
                                                                                right: 12,
                                                                              ),
                                                                              margin: const EdgeInsets.only(
                                                                                right: 8,
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    margin: const EdgeInsets.only(
                                                                                      right: 4,
                                                                                    ),
                                                                                    width: 39,
                                                                                    height: 37,
                                                                                    child: Image.network(
                                                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/459tckxf_expires_30_days.png",
                                                                                      fit: BoxFit.fill,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    "Bangun pagi",
                                                                                    style: TextStyle(
                                                                                      color: Color(
                                                                                        0xFF000000,
                                                                                      ),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        onTap: () {
                                                                          print(
                                                                            'Pressed',
                                                                          );
                                                                        },
                                                                        child: IntrinsicWidth(
                                                                          child: IntrinsicHeight(
                                                                            child: Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(
                                                                                  12,
                                                                                ),
                                                                                color: Color(
                                                                                  0xFFFFF7EC,
                                                                                ),
                                                                              ),
                                                                              padding: const EdgeInsets.only(
                                                                                top: 4,
                                                                                bottom: 4,
                                                                                left: 12,
                                                                                right: 12,
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    margin: const EdgeInsets.only(
                                                                                      right: 4,
                                                                                    ),
                                                                                    width: 39,
                                                                                    height: 37,
                                                                                    child: Image.network(
                                                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/t857ad3h_expires_30_days.png",
                                                                                      fit: BoxFit.fill,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    "Minum air",
                                                                                    style: TextStyle(
                                                                                      color: Color(
                                                                                        0xFF000000,
                                                                                      ),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            IntrinsicWidth(
                                                              child: IntrinsicHeight(
                                                                child: Container(
                                                                  margin:
                                                                      const EdgeInsets.only(
                                                                        bottom:
                                                                            8,
                                                                      ),
                                                                  child: Row(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: () {
                                                                          print(
                                                                            'Pressed',
                                                                          );
                                                                        },
                                                                        child: IntrinsicWidth(
                                                                          child: IntrinsicHeight(
                                                                            child: Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(
                                                                                  12,
                                                                                ),
                                                                                color: Color(
                                                                                  0xFFFFF7EC,
                                                                                ),
                                                                              ),
                                                                              padding: const EdgeInsets.only(
                                                                                top: 4,
                                                                                bottom: 4,
                                                                                left: 12,
                                                                                right: 12,
                                                                              ),
                                                                              margin: const EdgeInsets.only(
                                                                                right: 8,
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    margin: const EdgeInsets.only(
                                                                                      right: 4,
                                                                                    ),
                                                                                    width: 39,
                                                                                    height: 37,
                                                                                    child: Image.network(
                                                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/qk8jbomn_expires_30_days.png",
                                                                                      fit: BoxFit.fill,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    "Minum vitamin",
                                                                                    style: TextStyle(
                                                                                      color: Color(
                                                                                        0xFF000000,
                                                                                      ),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        onTap: () {
                                                                          print(
                                                                            'Pressed',
                                                                          );
                                                                        },
                                                                        child: IntrinsicWidth(
                                                                          child: IntrinsicHeight(
                                                                            child: Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(
                                                                                  12,
                                                                                ),
                                                                                color: Color(
                                                                                  0xFFFFF7EC,
                                                                                ),
                                                                              ),
                                                                              padding: const EdgeInsets.only(
                                                                                top: 4,
                                                                                bottom: 4,
                                                                                left: 12,
                                                                                right: 12,
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    margin: const EdgeInsets.only(
                                                                                      right: 4,
                                                                                    ),
                                                                                    width: 39,
                                                                                    height: 37,
                                                                                    child: Image.network(
                                                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/hoy4jvdt_expires_30_days.png",
                                                                                      fit: BoxFit.fill,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    "Makan buah",
                                                                                    style: TextStyle(
                                                                                      color: Color(
                                                                                        0xFF000000,
                                                                                      ),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            IntrinsicWidth(
                                                              child: IntrinsicHeight(
                                                                child: Row(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap: () {
                                                                        print(
                                                                          'Pressed',
                                                                        );
                                                                      },
                                                                      child: IntrinsicWidth(
                                                                        child: IntrinsicHeight(
                                                                          child: Container(
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(
                                                                                12,
                                                                              ),
                                                                              color: Color(
                                                                                0xFFFFF7EC,
                                                                              ),
                                                                            ),
                                                                            padding: const EdgeInsets.only(
                                                                              top: 4,
                                                                              bottom: 4,
                                                                              left: 12,
                                                                              right: 12,
                                                                            ),
                                                                            margin: const EdgeInsets.only(
                                                                              right: 8,
                                                                            ),
                                                                            child: Row(
                                                                              children: [
                                                                                Container(
                                                                                  margin: const EdgeInsets.only(
                                                                                    right: 4,
                                                                                  ),
                                                                                  width: 39,
                                                                                  height: 37,
                                                                                  child: Image.network(
                                                                                    "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/7jbhg7fx_expires_30_days.png",
                                                                                    fit: BoxFit.fill,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  "Makan sayuran",
                                                                                  style: TextStyle(
                                                                                    color: Color(
                                                                                      0xFF000000,
                                                                                    ),
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap: () {
                                                                        print(
                                                                          'Pressed',
                                                                        );
                                                                      },
                                                                      child: IntrinsicWidth(
                                                                        child: IntrinsicHeight(
                                                                          child: Container(
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(
                                                                                12,
                                                                              ),
                                                                              color: Color(
                                                                                0xFFFFF7EC,
                                                                              ),
                                                                            ),
                                                                            padding: const EdgeInsets.only(
                                                                              top: 4,
                                                                              bottom: 4,
                                                                              left: 12,
                                                                              right: 12,
                                                                            ),
                                                                            margin: const EdgeInsets.only(
                                                                              right: 22,
                                                                            ),
                                                                            child: Row(
                                                                              children: [
                                                                                Container(
                                                                                  margin: const EdgeInsets.only(
                                                                                    right: 4,
                                                                                  ),
                                                                                  width: 39,
                                                                                  height: 37,
                                                                                  child: Image.network(
                                                                                    "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/vhn5up3u_expires_30_days.png",
                                                                                    fit: BoxFit.fill,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  "Berjemur",
                                                                                  style: TextStyle(
                                                                                    color: Color(
                                                                                      0xFF000000,
                                                                                    ),
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          IntrinsicWidth(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  bottom: 1,
                                                ),
                                                margin: const EdgeInsets.only(
                                                  left: 20,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Lakukan kesadaran penuh",
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF000000,
                                                        ),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
