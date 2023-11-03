import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/create_review_caller.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({Key? key, required this.PRid}) : super(key: key);
  final int PRid;
  @override
  // ignore: library_private_types_in_public_api
  _CreateReviewScreenState createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController descriptionController = TextEditingController();
  int rating = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration:
                  const InputDecoration(labelText: 'Review Description'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Rating: '),
                DropdownButton<int>(
                  value: rating,
                  onChanged: (int? value) {
                    if (value != null) {
                      setState(() {
                        rating = value;
                      });
                    }
                  },
                  items: [1, 2, 3, 4, 5]
                      .map<DropdownMenuItem<int>>(
                        (int value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final description = descriptionController.text;
                final productId = widget.PRid;
                final response =
                    await createReview(description, productId, rating);

                if (response.isSuccess) {
                  Get.snackbar("Success", "Done");

                  final responseData = response.responseJson;
                  final reviewId = responseData!['data']['id'];
                } else {
                  Get.snackbar("Faild", "Try Again");
                }
              },
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
