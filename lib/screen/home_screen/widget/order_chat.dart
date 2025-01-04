import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderChat extends StatefulWidget {
  const OrderChat({super.key});

  @override
  State<OrderChat> createState() => _OrderChatState();
}

class _OrderChatState extends State<OrderChat> {
  bool isTranscriptExpanded = false;
  bool isOrderListExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 3.w, left: 8.w),
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
                        style:
                        TextStyle(color: Colors.grey, fontSize: 16.sp)),
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
                      style:
                      TextStyle(color: Colors.black, fontSize: 16.sp)),
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
                  ListTile(
                    leading: Icon(Icons.receipt, color: Colors.grey),
                    title: Text('Order No: 15544',
                        style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
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
                            color: Colors.green.shade100,
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
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.grey)),
                      ],
                    ),
                    Text('12:38 pm  ',
                        style:
                        TextStyle(fontSize: 14.sp, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          margin: EdgeInsets.only(
            left: 3.w,top: 2.h
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.shade50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ok, Got it!",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                "12:38 pm",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
