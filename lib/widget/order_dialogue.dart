import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'menu_dialogue.dart';

class OrderDialogue extends StatefulWidget {
  const OrderDialogue({super.key});

  @override
  State<OrderDialogue> createState() => _OrderDialogueState();
}

class _OrderDialogueState extends State<OrderDialogue> {
  bool isTranscriptExpanded = false;
  bool isOrderListExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(10.sp),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Slider(
                      value: 0,
                      min: 0,
                      max: 1.0,
                      activeColor: Colors.blue,
                      thumbColor: Colors.blue,
                      onChanged: (value) {},
                    ),
                    Text('01:23',
                        style: TextStyle(color: Colors.grey, fontSize: 16.sp)),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 3.w),
                minTileHeight: 4.h,
                title: Text('Transcript',
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                expandedAlignment: Alignment.center,
                trailing: Icon(
                  isTranscriptExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                onExpansionChanged: (expanded) {
                  setState(() => isTranscriptExpanded = expanded);
                },
                childrenPadding: EdgeInsets.symmetric(horizontal: 3.w),
                children: [
                  Text(
                      'Wanted to place an order for few items,Here is what I need: First, 50 units of the Classic Leather Wallet in black. Next, 30 units of the Summer Floral Dress.',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp)),
                  SizedBox(
                    height: 0.5.h,
                  )
                ],
              ),
              ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 3.w),
                minTileHeight: 4.h,
                title: Text('Order List',
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                trailing: Icon(
                  isOrderListExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                onExpansionChanged: (expanded) {
                  setState(() => isOrderListExpanded = expanded);
                },
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 3.w,
                          children: [
                            Text(
                              "Milk",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              "5 Packets",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 3.w,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 0.4.h),
                              margin: EdgeInsets.symmetric(vertical: 0.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue.shade50),
                              child: Text(
                                "00:33",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 0.5.h),
                                margin: EdgeInsets.symmetric(vertical: 0.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: Icon(Icons.edit_outlined)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                child: Row(
                  spacing: 2.w,
                  children: [
                    Icon(
                      Icons.receipt,
                      color: Colors.black,
                      size: 17.sp,
                    ),
                    Text('Order No: 15544',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Approval Message
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.3.h),
                          margin: EdgeInsets.only(left: 2.w),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            'Approved by DP on 02:30pm, 15/07/2024',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Version and Timestamp
                        Text(' V.1',
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.grey)),
                      ],
                    ),
                    Text('12:38 pm  ',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
