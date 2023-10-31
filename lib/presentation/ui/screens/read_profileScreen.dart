import 'package:crafty_bay_app/data/models/Profile_model.dart';
import 'package:crafty_bay_app/data/models/network_response.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:flutter/material.dart';

import '../../../data/utility/urls.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileModel? _profile;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() async {
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.ReadProfile);

    if (response.isSuccess) {
      setState(() {
        if (response.responseJson != null) {
          _profile = ProfileModel.fromJson(response.responseJson!);
        }
      });
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to load profile data.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: Center(
        child: _profile == null
            ? const CircularProgressIndicator()
            : buildProfileDetails(),
      ),
    );
  }

  Widget buildProfileDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png"),
            radius: 50,
          ),
        ),
        Center(
          child: Text(
            _profile!.data?.cusName ?? 'N/A',
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          _profile!.data?.user?.email ?? 'N/A',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
        ),
        const SizedBox(height: 20),
        ProfileInfos("Phone Number:", _profile!.data?.cusPhone ?? 'N/A'),
        ProfileInfos("Receiver Name:", _profile!.data?.shipName ?? 'N/A'),
        ProfileInfos("Shipping Address:", _profile!.data?.shipAdd ?? 'N/A'),
        ProfileInfos(
            "Receiver Phone Number:", _profile!.data?.shipPhone ?? 'N/A'),
      ],
    );
  }

  Column ProfileInfos(String InfoName, String Info) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(InfoName,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black)),
        const SizedBox(height: 3),
        Text(Info,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black)),
        const SizedBox(height: 10),
      ],
    );
  }
}
