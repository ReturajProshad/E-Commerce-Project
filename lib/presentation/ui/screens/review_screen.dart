import 'create_review_screen.dart';
import '../utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ReviewsAppBar,
                    const ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Person name"),
                      subtitle: Text("Person's review will be here"),
                    ),
                  ],
                ),
              ),
            ),
            cartToCartBottomContainer,
          ],
        ),
      ),
    );
  }

  AppBar get ReviewsAppBar {
    return AppBar(
      leading: const BackButton(
        color: Colors.black54,
      ),
      title: const Text(
        'Reviews',
        style: TextStyle(color: Colors.black54),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      bottomOpacity: 1.0,
    );
  }

  Container get cartToCartBottomContainer {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reviews',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '(1000)',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.primaryColor),
              ),
            ],
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            splashColor: Color.fromRGBO(4, 0, 226, 1),
            backgroundColor: Colors.red,
            onPressed: () {
              Get.to(CreateReviewScreen() ?? " ");
            },
          )
        ],
      ),
    );
  }
}
