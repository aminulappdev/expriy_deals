
import 'package:expriy_deals/app/modules/order/widgets/my_order_card.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  String selectedType = "All";
  final List<String> options = [
    "All",
    "pending",
    "processing",
    "Delivered",
  ];

  // Static list of orders
  final List<Map<String, dynamic>> staticOrders = [
    {
      'id': '1',
      'amount': '99.99',
      'status': 'pending',
      'items': [
        {
          'quantity': 2,
          'product': {
            'name': 'Product 1',
            'images': [
              {'url': 'https://example.com/image1.jpg'}
            ]
          }
        }
      ]
    },
    {
      'id': '2',
      'amount': '149.99',
      'status': 'processing',
      'items': [
        {
          'quantity': 1,
          'product': {
            'name': 'Product 2',
            'images': [
              {'url': 'https://example.com/image2.jpg'}
            ]
          }
        }
      ]
    },
    {
      'id': '3',
      'amount': '199.99',
      'status': 'Delivered',
      'items': [
        {
          'quantity': 3,
          'product': {
            'name': 'Product 3',
            'images': [
              {'url': 'https://example.com/image3.jpg'}
            ]
          }
        }
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox20,
            CustomAppBar(name: "My Orders"),
            Row(
              children: [
                Text(
                  "Choose Your Type:",
                  style: GoogleFonts.poppins(fontSize: 15.sp),
                ),
                SizedBox(width: 10.h),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFF6ECE4),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedType,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
                        items: options.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(
                              option,
                              style: GoogleFonts.poppins(fontSize: 12.sp),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedType = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Builder(builder: (context) {
                final filteredOrders = selectedType == 'All'
                    ? staticOrders
                    : staticOrders
                        .where((order) => order['status'] == selectedType)
                        .toList();

                if (filteredOrders.isEmpty) {
                  return Center(
                    child: Text(
                      'No orders found.',
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    final item = order['items'][0];
                    final product = item['product'];
                    final imageUrl = product['images'].isNotEmpty
                        ? product['images'][0]['url']
                        : '';

                    return MyOrderCard(
                      imagePath: imageUrl,
                      price: '${order['amount']}',
                      productName: product['name'] ?? "Unknown",
                      quantity: '${item['quantity']}',
                      isShowSeconBTN: order['status'] != 'pending',
                      status: '${order['status']}',
                      mainBTNOntap: () {
                       
                      },
                      secondBTNOntap: () {},
                      secondBTNName: 'Buy Again',
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}