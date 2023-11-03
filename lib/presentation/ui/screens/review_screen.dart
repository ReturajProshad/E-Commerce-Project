import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utility/urls.dart';

import '../../../data/models/Review_model.dart';
import 'create_review_screen.dart';
import '../utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({Key? key, required this.Pid}) : super(key: key);
  final int Pid;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late Future<List<Data>?> reviews;
  int totalReviews = 0;
  @override
  void initState() {
    super.initState();
    reviews = fetchReviews();
  }

  Future<List<Data>?> fetchReviews() async {
    final response =
        await NetworkCaller.getRequest(Urls.getReviewsbyid(widget.Pid));
    if (response.isSuccess) {
      final reviewModel = ReviewModel.fromJson(response.responseJson ?? {});
      setState(() {
        totalReviews = reviewModel.data?.length ?? 0;
      });
      return reviewModel.data;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ReviewsAppBar,
          Expanded(
            child: FutureBuilder<List<Data>?>(
              future: reviews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No reviews available.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final review = snapshot.data![index];
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(review.profile?.cusName ?? "No Name"),
                        subtitle: Text(review.description ?? "No Review"),
                      );
                    },
                  );
                }
              },
            ),
          ),
          cartToCartBottomContainer,
        ],
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reviews',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black54),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '($totalReviews)',
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.primaryColor),
              ),
            ],
          ),
          FloatingActionButton(
            splashColor: const Color.fromRGBO(4, 0, 226, 1),
            backgroundColor: Colors.red,
            onPressed: () {
              print(widget.Pid);
              Get.to(CreateReviewScreen(
                PRid: widget.Pid,
              ));
            },
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
