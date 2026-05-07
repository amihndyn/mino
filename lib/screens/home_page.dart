import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/b4zo9oht_expires_30_days.png",
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
                              padding: const EdgeInsets.only(top: 18),
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
                                        bottom: 37,
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
                                              "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/bg8x8gaq_expires_30_days.png",
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
                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/m8pyg7cm_expires_30_days.png",
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
                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/yyv38x5t_expires_30_days.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 28,
                                                    height: 13,
                                                    child: Image.network(
                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/72w2zuw1_expires_30_days.png",
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
                                      margin: const EdgeInsets.only(
                                        bottom: 33,
                                        left: 20,
                                        right: 20,
                                      ),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IntrinsicWidth(
                                            child: IntrinsicHeight(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                          bottom: 2,
                                                          right: 20,
                                                        ),
                                                    child: Text(
                                                      "Hi, Keysha",
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFFFFFFFF,
                                                        ),
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Wednesday, April 22, 2026",
                                                    style: TextStyle(
                                                      color: Color(0xFFE6A84A),
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          IntrinsicWidth(
                                            child: IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      print('Pressed');
                                                    },
                                                    child: IntrinsicWidth(
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: Color(
                                                                0xFFE6A84A,
                                                              ),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                            color: Color(
                                                              0x33E6A84A,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.all(
                                                                10,
                                                              ),
                                                          margin:
                                                              const EdgeInsets.only(
                                                                right: 12,
                                                              ),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            20,
                                                                          ),
                                                                    ),
                                                                margin:
                                                                    const EdgeInsets.only(
                                                                      right: 4,
                                                                    ),
                                                                width: 26,
                                                                height: 26,
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        20,
                                                                      ),
                                                                  child: Image.network(
                                                                    "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/9je9kcs2_expires_30_days.png",
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                "80",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFFFFFFFF,
                                                                  ),
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 46,
                                                    height: 46,
                                                    child: Image.network(
                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/mjq4l9n0_expires_30_days.png",
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
                                      margin: const EdgeInsets.only(
                                        bottom: 33,
                                        left: 18,
                                        right: 18,
                                      ),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  right: 16,
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            bottom: 9,
                                                          ),
                                                      child: Text(
                                                        "Sun",
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFFFFFFFF,
                                                          ),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print('Pressed');
                                                      },
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: Color(
                                                                0xFFE6A84A,
                                                              ),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                            color: Color(
                                                              0x1A48280C,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                vertical: 8,
                                                              ),
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "19",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFFE6A84A,
                                                                  ),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  right: 16,
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            bottom: 9,
                                                          ),
                                                      child: Text(
                                                        "Mon",
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFFE6A84A,
                                                          ),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print('Pressed');
                                                      },
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: Color(
                                                                0xFF59463D,
                                                              ),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                            color: Color(
                                                              0xFFE6A84A,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                vertical: 8,
                                                              ),
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "20",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFF59463D,
                                                                  ),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  right: 16,
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            bottom: 9,
                                                          ),
                                                      child: Text(
                                                        "Tue",
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFFFFFFFF,
                                                          ),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print('Pressed');
                                                      },
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: Color(
                                                                0xFFE6A84A,
                                                              ),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                            color: Color(
                                                              0x1A48280C,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                vertical: 8,
                                                              ),
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "21",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFFE6A84A,
                                                                  ),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  right: 16,
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            bottom: 9,
                                                          ),
                                                      child: Text(
                                                        "Wed",
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFFFFFFFF,
                                                          ),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print('Pressed');
                                                      },
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: Color(
                                                                0xFFE6A84A,
                                                              ),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                            color: Color(
                                                              0x1A48280C,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                vertical: 8,
                                                              ),
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "22",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFFE6A84A,
                                                                  ),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  right: 16,
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            bottom: 9,
                                                          ),
                                                      child: Text(
                                                        "Thu",
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFFFFFFFF,
                                                          ),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print('Pressed');
                                                      },
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: Color(
                                                                0xFFE6A84A,
                                                              ),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                            color: Color(
                                                              0x1A48280C,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                vertical: 8,
                                                              ),
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "23",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFFE6A84A,
                                                                  ),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  right: 16,
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            bottom: 9,
                                                          ),
                                                      child: Text(
                                                        "Fri",
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFFFFFFFF,
                                                          ),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print('Pressed');
                                                      },
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: Color(
                                                                0xFFE6A84A,
                                                              ),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                            color: Color(
                                                              0x1A48280C,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                vertical: 8,
                                                              ),
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "24",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFFE6A84A,
                                                                  ),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            bottom: 9,
                                                          ),
                                                      child: Text(
                                                        "Sat",
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFFFFFFFF,
                                                          ),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        print('Pressed');
                                                      },
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: Color(
                                                                0xFFE6A84A,
                                                              ),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                            color: Color(
                                                              0x1A48280C,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                vertical: 8,
                                                              ),
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "25",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFFE6A84A,
                                                                  ),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IntrinsicHeight(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFFE6A84A),
                                          width: 4,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          begin: Alignment(-1, -1),
                                          end: Alignment(-1, 1),
                                          colors: [
                                            Color(0xFFFF9800),
                                            Color(0xFFFFFDFB),
                                            Color(0xFFFFD799),
                                          ],
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(
                                        top: 22,
                                        bottom: 22,
                                        left: 33,
                                        right: 33,
                                      ),
                                      margin: const EdgeInsets.only(
                                        bottom: 29,
                                        left: 20,
                                        right: 20,
                                      ),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  right: 12,
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    IntrinsicHeight(
                                                      child: Container(
                                                        margin:
                                                            const EdgeInsets.only(
                                                              bottom: 9,
                                                            ),
                                                        width: double.infinity,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets.only(
                                                                    bottom: 4,
                                                                  ),
                                                              child: Text(
                                                                "Add Reflection",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFF59463D,
                                                                  ),
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 136,
                                                              child: Text(
                                                                "How are you feeling today?",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFF59463D,
                                                                  ),
                                                                  fontSize: 14,
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
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  26,
                                                                ),
                                                            color: Color(
                                                              0xFF59463D,
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color(
                                                                  0x80FEDF66,
                                                                ),
                                                                blurRadius: 21,
                                                                offset: Offset(
                                                                  0,
                                                                  0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          padding:
                                                              const EdgeInsets.only(
                                                                left: 49,
                                                              ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              IntrinsicWidth(
                                                                child: IntrinsicHeight(
                                                                  child: Container(
                                                                    padding:
                                                                        const EdgeInsets.only(
                                                                          top:
                                                                              6,
                                                                          bottom:
                                                                              6,
                                                                          left:
                                                                              5,
                                                                          right:
                                                                              56,
                                                                        ),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            26,
                                                                          ),
                                                                      image: DecorationImage(
                                                                        image: NetworkImage(
                                                                          "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/nfm3jh82_expires_30_days.png",
                                                                        ),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Next",
                                                                          style: TextStyle(
                                                                            color: Color(
                                                                              0xFFE6A84A,
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
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            width: 113,
                                            height: 93,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/hmsifk65_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 19,
                                      left: 20,
                                    ),
                                    child: Text(
                                      "Daily Activities",
                                      style: TextStyle(
                                        color: Color(0xFFE6A84A),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IntrinsicHeight(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFF59463D),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Color(0xFFE6A84A),
                                      ),
                                      padding: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        left: 11,
                                        right: 11,
                                      ),
                                      margin: const EdgeInsets.only(
                                        bottom: 15,
                                        left: 20,
                                        right: 20,
                                      ),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            margin: const EdgeInsets.only(
                                              right: 42,
                                            ),
                                            width: 38,
                                            height: 38,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/6y2xse2g_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  right: 43,
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Take a deep breath",
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF59463D,
                                                        ),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            width: 36,
                                            height: 36,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/p991vzks_expires_30_days.png",
                                                fit: BoxFit.fill,
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
                                        border: Border.all(
                                          color: Color(0xFF59463D),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Color(0xFFE6A84A),
                                      ),
                                      padding: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        left: 11,
                                        right: 11,
                                      ),
                                      margin: const EdgeInsets.only(
                                        bottom: 15,
                                        left: 20,
                                        right: 20,
                                      ),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            margin: const EdgeInsets.only(
                                              right: 42,
                                            ),
                                            width: 38,
                                            height: 38,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/jsa2ua41_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  right: 43,
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Smile for a few seconds",
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF59463D,
                                                        ),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            width: 36,
                                            height: 36,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/y331yyto_expires_30_days.png",
                                                fit: BoxFit.fill,
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
                                        border: Border.all(
                                          color: Color(0xFF59463D),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Color(0xFFE6A84A),
                                      ),
                                      padding: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        left: 11,
                                        right: 11,
                                      ),
                                      margin: const EdgeInsets.only(
                                        bottom: 15,
                                        left: 20,
                                        right: 20,
                                      ),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            margin: const EdgeInsets.only(
                                              right: 42,
                                            ),
                                            width: 38,
                                            height: 38,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/zbfokgik_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  right: 43,
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Fix your posture",
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF59463D,
                                                        ),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            width: 36,
                                            height: 36,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/fkrk24jg_expires_30_days.png",
                                                fit: BoxFit.fill,
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
                                        border: Border.all(
                                          color: Color(0xFF59463D),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Color(0xFFE6A84A),
                                      ),
                                      padding: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        left: 11,
                                        right: 11,
                                      ),
                                      margin: const EdgeInsets.only(
                                        bottom: 34,
                                        left: 20,
                                        right: 20,
                                      ),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            margin: const EdgeInsets.only(
                                              right: 42,
                                            ),
                                            width: 38,
                                            height: 38,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/gbax4ort_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  right: 43,
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Release tension in your body",
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF59463D,
                                                        ),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            width: 36,
                                            height: 36,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/tyz0z28j_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IntrinsicHeight(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 24,
                                        right: 24,
                                      ),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/egcg1deb_expires_30_days.png",
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  top: 37,
                                                  right: 16,
                                                ),
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
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
                                                                  padding:
                                                                      const EdgeInsets.only(
                                                                        left: 4,
                                                                        right:
                                                                            4,
                                                                      ),
                                                                  margin:
                                                                      const EdgeInsets.only(
                                                                        bottom:
                                                                            8,
                                                                      ),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        margin: const EdgeInsets.only(
                                                                          bottom:
                                                                              4,
                                                                        ),
                                                                        width:
                                                                            25,
                                                                        height:
                                                                            25,
                                                                        child: Image.network(
                                                                          "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/q4721g1s_expires_30_days.png",
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "Today",
                                                                        style: TextStyle(
                                                                          color: Color(
                                                                            0xFFE6A84A,
                                                                          ),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.only(
                                                                      topLeft:
                                                                          Radius.circular(
                                                                            4,
                                                                          ),
                                                                      topRight:
                                                                          Radius.circular(
                                                                            4,
                                                                          ),
                                                                    ),
                                                                gradient: LinearGradient(
                                                                  begin:
                                                                      Alignment(
                                                                        -1,
                                                                        -1,
                                                                      ),
                                                                  end:
                                                                      Alignment(
                                                                        -1,
                                                                        1,
                                                                      ),
                                                                  colors: [
                                                                    Color(
                                                                      0xFFE6A84A,
                                                                    ),
                                                                    Color(
                                                                      0xFF805D29,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              width: 51,
                                                              height: 4,
                                                              child: SizedBox(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    IntrinsicWidth(
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                bottom: 12,
                                                              ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets.only(
                                                                      bottom: 4,
                                                                      left: 13,
                                                                    ),
                                                                width: 25,
                                                                height: 25,
                                                                child: Image.network(
                                                                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/om78au3g_expires_30_days.png",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Journal",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFFE6A84A,
                                                                  ),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 10,
                                              right: 7,
                                            ),
                                            width: 70,
                                            height: 70,
                                            child: Image.network(
                                              "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/k29rdnay_expires_30_days.png",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  top: 37,
                                                ),
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                bottom: 12,
                                                              ),
                                                          margin:
                                                              const EdgeInsets.only(
                                                                right: 16,
                                                              ),
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets.only(
                                                                      bottom: 4,
                                                                      left: 23,
                                                                    ),
                                                                width: 25,
                                                                height: 25,
                                                                child: Image.network(
                                                                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/4kaebiaw_expires_30_days.png",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Challenge",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFFE6A84A,
                                                                  ),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                                          padding:
                                                              const EdgeInsets.only(
                                                                bottom: 12,
                                                                left: 2,
                                                                right: 2,
                                                              ),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets.only(
                                                                      bottom: 4,
                                                                    ),
                                                                width: 25,
                                                                height: 25,
                                                                child: Image.network(
                                                                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ucE5vdQcGS/7ixu2rsy_expires_30_days.png",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Profile",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFFE6A84A,
                                                                  ),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
